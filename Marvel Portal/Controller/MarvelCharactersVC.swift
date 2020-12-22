//
//  ViewController.swift
//  Marvel Portal
//
//  Created by codegradients on 12/12/2020.
//

import UIKit
import  Kingfisher

class MarvelCharactersVC: UIViewController {
    
    @IBOutlet weak var charactersNameCV: UICollectionView!
    
    let searchController = UISearchController()
    var charactersInfo = [CharactersInfo]()
    var filteredData = [CharactersInfo]()
    var apiManager = APIManager()
    var indexValue = 0
    var selectedCharacter = [CharactersInfo]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        charactersNameCV.dataSource = self
        charactersNameCV.delegate = self
        apiManager.delegate = self
        apiManager.performRequest(with: K.UrlString)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            
         ]
         self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = K.navigationTitle
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = K.Back
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? CharacterResourceVC {
            nextViewController.selectedCharacterIs = selectedCharacter
        }
    }
}
// MARK:- Characters Name CollectionView Extenssion
extension MarvelCharactersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredData.count
        }else {
            return charactersInfo.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexValue = indexPath.item
        let data = charactersInfo[indexValue]
        selectedCharacter = [data]
        navigationItem.searchController = nil
        performSegue(withIdentifier: K.segueCharactersInfo, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = filteredData[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CVcellIdentity, for: indexPath) as! MarvelCVCell
        cell.charactersNameLabel.text = data.name
        cell.IDLabel.text = String(data.id)
        cell.characterImage.kf.setImage(with: URL(string: data.characterImage))
        
        cell.characterImage.layer.cornerRadius = 10
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        initSearchController()
    }
}
// MARK:- ViewController: APIManagerDelegate
extension MarvelCharactersVC: APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersInfo]) {
        DispatchQueue.main.async {
            self.charactersInfo = jSONReturnData
            self.filteredData = self.charactersInfo
            self.charactersNameCV.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
// MARK:- UISearchController
extension MarvelCharactersVC: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filteredData = []
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        if searchText != "" {
            for searchItem in charactersInfo {
                if searchItem.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(searchItem)
                    searching = true
                    self.charactersNameCV.reloadData()
                }
            }
        }else {
            print("please enter some text")
            filteredData = charactersInfo
            self.charactersNameCV.reloadData()
        }
    }
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
