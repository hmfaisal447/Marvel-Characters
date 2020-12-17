//
//  MarvelCharactersInfoCV.swift
//  Marvel Portal
//
//  Created by codegradients on 14/12/2020.
//

import UIKit
import Kingfisher

class CharactersInfoVC: UIViewController {

    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var imageView: imageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterId: UILabel!
    
    var selectedCharacterIs = [CharactersName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtnOutlet.layer.cornerRadius = 10
        backBtnOutlet.layer.borderWidth = 2
        backBtnOutlet.layer.borderColor = UIColor.white.cgColor
        charactesInfo()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func charactesInfo() {
        characterId.text = String("ID: \(selectedCharacterIs[0].id)")
        characterName.text = selectedCharacterIs[0].name
        imageView.kf.setImage(with: URL(string: selectedCharacterIs[0].characterImage))

    }
}
class imageView: UIImageView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.roundUpCorners([.bottomLeft, .bottomRight], radius: 30)
    }
}
extension UIView {
    func roundUpCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
