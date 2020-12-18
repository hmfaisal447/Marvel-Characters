//
//  MarvelCharactersInfoCV.swift
//  Marvel Portal
//
//  Created by codegradients on 14/12/2020.
//

import UIKit
import Kingfisher

class CharactersInfoVC: UIViewController {
    
    @IBOutlet weak var imageView: imageView!
    @IBOutlet weak var characterId: UILabel!
    @IBOutlet weak var characterFirstName: UILabel!
    @IBOutlet weak var characterSecondName: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var selectedCh = [CharactersInfo]()
    var resourceVCSelectedIndexIs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedCh[0].name
        navigationItem.backButtonTitle = "Back"
        characterId.layer.borderWidth = 0.8
        characterId.layer.cornerRadius = 10
        characterFirstName.layer.borderWidth = 0.8
        characterFirstName.layer.cornerRadius = 10
        characterSecondName.layer.borderWidth = 0.8
        characterSecondName.layer.cornerRadius = 10
        textView.layer.borderWidth = 0.8
        textView.layer.cornerRadius = 10
        charactesInfo()
    }
    func charactesInfo() {
        characterId.text = String("\(selectedCh[0].id)")
        if selectedCh[0].description == "" {
            textView.text = "\(selectedCh[0].name) has no API description\n==>>\nURL: \(selectedCh[0].resourceData[resourceVCSelectedIndexIs].resourceUrl)"
        }else {
            textView.text = "\(selectedCh[0].description)\n==>>\nURL: \(selectedCh[0].resourceData[resourceVCSelectedIndexIs].resourceUrl)"
        }
        imageView.kf.setImage(with: URL(string: selectedCh[0].characterImage))
        characterFirstName.text = selectedCh[0].name
        characterSecondName.text = selectedCh[0].resourceData[resourceVCSelectedIndexIs].resourceName
    }
}
// MARK:- Round Image View
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
