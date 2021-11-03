//
//  String+Ext.swift
//  Diary-Project
//
//  Created by sookim on 2021/11/03.
//

import Foundation

extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
}
