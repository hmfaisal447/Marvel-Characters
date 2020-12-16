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
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterId: UILabel!
    
    var indexValueIs = 0
    let stringValue = [CharactersName]()
    
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
        let result = stringValue[indexValueIs].id
        //characterImage.kf.setImage(with: URL(string: result))
        characterId.text = String(result)
    }
}
