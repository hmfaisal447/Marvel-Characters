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
        //navigationItem.backButtonTitle = "Back"
        navigationItem.backButtonTitle = "Back"
        navigationItem.title = selectedCharacterIs[0].name
        charactersInfoCV.delegate = self
        charactersInfoCV.dataSource = self
        apiManager.delegate = self
        apiManager.performRequest(with: K.UrlString)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? CharactersInfoVC {
            nextViewController.selectedCh = selectedCharacterIs
            nextViewController.resourceVCSelectedIndexIs = resourceVCSelectedIndex
        }
    }
}

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
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 10
        return cell
    }
}
extension CharacterResourceVC: APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersInfo]) {
        DispatchQueue.main.async {
            self.stringValue = jSONReturnData
            self.charactersInfoCV.reloadData()
            //print(jSONReturnData.name)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
