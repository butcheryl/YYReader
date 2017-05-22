//
//  BookAPI.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Moya
import MoyaSugar

enum BookTarget {
    // book list
    case rank(page: Int)
    case serials(page: Int)
    case complete(page: Int)
}

extension BookTarget: YYReaderTargetType {
    
    var route: Route {
        switch self {
        case .rank(let page):
            return .get("book/allvisit/0/\(page)")
        case .serials(let page):
            return .get("book/lastupdate/0/\(page)")
        case .complete(let page):
            return .get("book1/0/\(page)")
        }
    }
    
    var params: Parameters? {
        return nil
    }
}
