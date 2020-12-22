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
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imageUiView: UIView!
    
    
    var selectedCh = [CharactersInfo]()
    var resourceVCSelectedIndexIs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedCh[0].name
        charactesInfo()
    }
    // MARK:- charactesInfo Display Content and also shadow the objects
    func charactesInfo() {
        // MARK:- objects shadow
        uiView.layer.cornerRadius = 25
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowRadius = 6.0
        uiView.layer.shadowOpacity = 0.6
        uiView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        uiView.layer.masksToBounds = false
        imageUiView.layer.cornerRadius = 30
        imageUiView.layer.shadowColor = UIColor.black.cgColor
        imageUiView.layer.shadowRadius = 8.0
        imageUiView.layer.shadowOpacity = 0.8
        imageUiView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        imageUiView.layer.masksToBounds = false
        // MARK:- Display Content
        characterId.text = String("\(selectedCh[0].id)")
        if selectedCh[0].description == "" {
            textView.text = "\(K.contentSeperationStyle)\n\(selectedCh[0].name) has no API description\n\(K.contentSeperationStyle)\nURL: \(selectedCh[0].resourceData[resourceVCSelectedIndexIs].resourceUrl)"
        }else {
            textView.text = "\(K.contentSeperationStyle)\n\(selectedCh[0].description)\n\(K.contentSeperationStyle)\nURL: \(selectedCh[0].resourceData[resourceVCSelectedIndexIs].resourceUrl)"
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
