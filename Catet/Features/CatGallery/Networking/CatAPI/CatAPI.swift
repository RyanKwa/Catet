//
//  CatAPI.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import Foundation

struct CatAPI: Codable {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
}

/*
 MARK: CatAPI
 MARK: endpoint: https://api.thecatapi.com/v1/images/search?breed_ids=abys
 {
    "id": "tv8tNeYaU",
    "url": "https://cdn2.thecatapi.com/images/tv8tNeYaU.jpg",
    "width": 1600,
    "height": 1200
 }
 */

