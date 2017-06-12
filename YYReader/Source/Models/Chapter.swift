//
//  Chapter.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation

struct Paragraph {
    var text: String
}

struct Chapter {
    var id: Int
    var number: Int
    var title: String
    var hasCache: Bool = false
    
    init(id: Int, number: Int, title: String, hasCache: Bool) {
        self.id = id
        self.number = number
        self.title = title
        self.hasCache = hasCache
    }
    
    init(number: Int, title: String) {
        self.init(id: 0, number: number, title: title, hasCache: false)
    }
}
