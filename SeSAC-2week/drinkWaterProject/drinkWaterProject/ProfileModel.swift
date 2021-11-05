//
//  ProfileModel.swift
//  drinkWaterProject
//
//  Created by sookim on 2021/11/05.
//

import Foundation

struct ProfileModel: Codable {

    let nickname: String!
    let height: Double!
    let weight: Double!

    func recommendWaterAmount() -> Double {
        return (height + weight) / 100
    }
}
