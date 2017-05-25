//
//  Book.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import Then

struct Book {
    
    enum Category: Int {
        case xuanhuan = 1
        case wuxia
        case dushi
        case yanqing
        case chuanyue
        case wangyou
        case kongbu
        case kehuan
        case other
        
        var uri: String {
            return "book\(rawValue)/0"
        }
    }
    
    var uri: String = ""
    
    var name: String = ""
    
    var author: String?
    
    var category: String?
    
    var cover: String?

    var desc: String?
    
    var chapters: [Chapter] = []
    
    init() {}
}

extension Book: Then {}
