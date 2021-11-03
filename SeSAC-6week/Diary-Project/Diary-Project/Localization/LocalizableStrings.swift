//
//  LocalizableStrings.swift
//  Diary-Project
//
//  Created by sookim on 2021/11/03.
//

import Foundation

enum LocalizebleStrings: String {
    case homeTitle = "home_title"
    case searchTitle = "search_title"
    
    var localized: String {
        return self.rawValue.localized
    }
}
