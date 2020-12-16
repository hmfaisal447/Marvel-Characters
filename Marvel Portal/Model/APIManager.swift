//
//  StoreAPICodeFile.swift
//  book store
//
//  Created by codegradients on 10/12/2020.
//

import Foundation
import UIKit
protocol APIManagerDelegate {
    func didUpdate(jSONReturnData: [CharactersName])
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
    func parseJSON(_ getAPIData: Data) -> [CharactersName]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(APICharactersList.self, from: getAPIData)
            var arr: [CharactersName] = []
            for count in 0...19 {
            let name = decodeData.data.results[count].name
            let id = decodeData.data.results[count].id
                let ImageUrl = decodeData.data.results[count].thumbnail.path
                let extention = decodeData.data.results[count].thumbnail.thumbnailExtension
                let characterImage = "\(ImageUrl).\(extention)"
                let returnValueIs = CharactersName(name: name, id: id, characterImage: characterImage)
            arr.append(returnValueIs)
            }
            return arr
        }catch {
            self.delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}

