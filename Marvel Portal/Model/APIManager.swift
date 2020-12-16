//
//  StoreAPICodeFile.swift
//  book store
//
//  Created by codegradients on 10/12/2020.
//

import Foundation
import UIKit
protocol APIManagerDelegate {
    func didUpdate(storeReturnData: String)
    func didFailWithError(error: Error)
}
struct APIManager {
    var delegate: APIManagerDelegate?
    func performRequest(with storeUrl: String) {
        if let url = URL(string: storeUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let storeData = self.parseJSON(safeData) {
                        self.delegate?.didUpdate(storeReturnData: storeData)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ getStoreData: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CharactersList.self, from: getStoreData)
            var arr: [MarvelCharactersName] = []
            for count in 0...3 {
                let name = decodedData.
            let returnValue = StoreReturnData(name: name, price: price, image: image)
            arr.append(returnValue)
            }
            return arr
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
