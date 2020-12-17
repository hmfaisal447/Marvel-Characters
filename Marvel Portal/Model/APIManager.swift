//
//  StoreAPICodeFile.swift
//  book store
//
//  Created by codegradients on 10/12/2020.
//

import Foundation
import UIKit
protocol APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersInfo])
    func didFailWithError(error: Error)
}
struct APIManager {
    var delegate: APIManagerDelegate?
    func performRequest(with UrlString: String) {
        if let url = URL(string: UrlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let parsingData = self.parseJSON(safeData) {
                        self.delegate?.didUpdate(jSONReturnData: parsingData)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ getAPIData: Data) -> [CharactersInfo]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(APICharactersList.self, from: getAPIData)
            var arr: [CharactersInfo] = []
            var resourceArr: [ResourceInfo] = []
            for item in decodeData.data.results {
                let name = item.name
                let id = item.id
                let ImageUrl = item.thumbnail.path
                let extention = item.thumbnail.thumbnailExtension
                let characterImage = "\(ImageUrl).\(extention)"
                let description = item.description
                for count in item.comics.items {
                    let resourceName = count.name
                    let resourceUrl = count.resourceURI
                    let returnResource = ResourceInfo(resourceName: resourceName, resourceUrl: resourceUrl)
                    resourceArr.append(returnResource)
                }
                let returnValueIs = CharactersInfo(name: name, id: id, characterImage: characterImage, description: description, resourceData: resourceArr)
                arr.append(returnValueIs)
            }
            return arr
        }catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

