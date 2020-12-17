//
//  MarvelCharactersName.swift
//  Marvel Portal
//
//  Created by codegradients on 14/12/2020.
//

import Foundation
struct CharactersInfo {
    let name: String
    let id: Int
    let characterImage: String
    let description: String
    let resourceData: [ResourceInfo]
}
struct ResourceInfo {
    let resourceName: String
    let resourceUrl: String
}
