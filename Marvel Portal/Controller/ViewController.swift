//
//  ViewController.swift
//  Marvel Portal
//
//  Created by codegradients on 12/12/2020.
//

import UIKit
import  Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var charactersNameCV: UICollectionView!
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    var stringValue = [CharactersInfo]()
    
    var apiManager = APIManager()
    var indexValue = 0
    var selectedCharacter = [CharactersInfo]()
    var searchedCharacter = [String]()
    var searching = false
    let charactersNameArr = ["3-D Man","A-Bomb (HAS)","A.I.M.","Aaron Stack","Abomination (Emil Blonsky)","Abomination (Ultimate)","Absorbing Man","Abyss","Abyss (Age of Apocalypse)","Adam Destine","Adam Warlock","Aegis (Trey Rollins)","Agent Brand","Agent X (Nijo)","Agent Zero","Agents of Atlas","Aginar","Air-Walker (Gabriel Lan)","Ajak","Ajaxis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Marvel Characters"
        characterSearchBar.delegate = self
        charactersNameCV.dataSource = self
        charactersNameCV.delegate = self
        apiManager.delegate = self
        apiManager.performRequest(with: K.UrlString)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? CharacterResourceVC {
            //nextViewController.selectedCharacterIs = selectedCharacter
            nextViewController.selectedCharacterIs = selectedCharacter
        }
    }
}
// MARK:- Characters Name CollectionView Extenssion
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchedCharacter.count
        } else {
            return stringValue.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexValue = indexPath.item
        let data = stringValue[indexValue]
        selectedCharacter = [data]
        performSegue(withIdentifier: K.segueCharactersInfo, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = stringValue[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CVcellIdentity, for: indexPath) as! MarvelCVCell
        cell.charactersNameLabel.text = data.name
        cell.IDLabel.text = String(data.id)
        cell.characterImage.kf.setImage(with: URL(string: data.characterImage))
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 10
        cell.characterImage.layer.cornerRadius = 10
        if searching {
            cell.charactersNameLabel.text = data.name
        } else {
            cell.charactersNameLabel.text = data.name
        }
        return cell
    }
}
extension ViewController: APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersInfo]) {
        DispatchQueue.main.async {
            self.stringValue = jSONReturnData
            self.charactersNameCV.reloadData()
            //print(jSONReturnData.name)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCharacter = charactersNameArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        charactersNameCV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        charactersNameCV.reloadData()
    }
    
}
