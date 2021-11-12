//
//  Memo.swift
//  MemoApp
//
//  Created by sookim on 2021/11/10.
//

import Foundation

struct Memo: Codable {
    let title: String
    let body: String
    let writeDate: Date
    
    static var memoList: [Memo] = []
    static var fixMemoList: [Memo] = []
}
