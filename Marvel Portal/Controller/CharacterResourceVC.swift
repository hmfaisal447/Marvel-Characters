//
//  CharacterResourceVC.swift
//  Marvel Portal
//
//  Created by codegradients on 17/12/2020.
//

import UIKit

class CharacterResourceVC: UIViewController {
    
    @IBOutlet weak var charactersInfoCV: UICollectionView!
    
    var apiManager = APIManager()
    var stringValue = [CharactersInfo]()
    var indexValueIs = 0
    var innerIndex = 0
    var selectedCharacterIs = [CharactersInfo]()
    var resourceVCSelectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersInfoCV.delegate = self
        charactersInfoCV.dataSource = self
        apiManager.delegate = self
        apiManager.performRequest(with: K.UrlString)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = selectedCharacterIs[0].name
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = "Back"
    }
    
    // MARK:- prepareSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? CharactersInfoVC {
            nextViewController.selectedCh = selectedCharacterIs
            nextViewController.resourceVCSelectedIndexIs = resourceVCSelectedIndex
        }
    }
}
// MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension CharacterResourceVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        innerIndex = selectedCharacterIs[indexValueIs].resourceData.count
        return selectedCharacterIs[indexValueIs].resourceData.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resourceVCSelectedIndex = indexPath.item
        performSegue(withIdentifier: K.segueInfoVC, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = selectedCharacterIs[indexValueIs].resourceData[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.resourceIdentifier, for: indexPath) as! MarvelCVCell
        cell.characterResourceName.text = data.resourceName
        cell.characterResourceUrl.text = data.resourceUrl
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.1)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
}
// MARK:- CharacterResourceVC: APIManagerDelegate
extension CharacterResourceVC: APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersInfo]) {
        DispatchQueue.main.async {
            self.stringValue = jSONReturnData
            self.charactersInfoCV.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
