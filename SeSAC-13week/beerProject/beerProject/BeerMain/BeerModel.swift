//
//  BeerModel.swift
//  beerProject
//
//  Created by sookim on 2021/12/27.
//

import Foundation

struct BeerModel: Codable {
    let name: String
    let description: String
    let imageUrl: String
    let foodPairing: [String]
    let brewersTips: String
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case imageUrl = "image_url"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}

