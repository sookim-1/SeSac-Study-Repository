//
//  ParsingModel.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import Foundation

struct Beer: Codable, Hashable {
    var name: String
    var description: String
    var image_url: String

//    enum CodingKeys: String, CodingKey {
//        case name, description
//        case imageURL = "image_url"
//    }
}
