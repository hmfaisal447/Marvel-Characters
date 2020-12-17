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
    @IBOutlet weak var textView: UITextView!
    
    var selectedCharacterIs = [CharactersInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedCharacterIs[0].name
        navigationItem.backButtonTitle = "Back"
        
        charactesInfo()
    }
    func charactesInfo() {
        //characterId.text = String("ID: \(selectedCharacterIs[0].id)")
        if selectedCharacterIs[0].description == "" {
            textView.text = "This character has no description in API"
        }else {
            textView.text = selectedCharacterIs[0].description
        }
        imageView.kf.setImage(with: URL(string: selectedCharacterIs[0].characterImage))
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
