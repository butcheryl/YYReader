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
    case category(uri: String, page: Int)
    case rank(page: Int)
    case serials(page: Int)
    case complete(page: Int)
    
    case bookInfo(uri: String)
    
    case catalog(uri: String)
    
}

extension BookTarget: YYReaderTargetType {
    
    var route: Route {
        switch self {
        case .category(let uri, let page):
            return .get("\(uri)/\(page)")
        case .rank(let page):
            return .get("book/allvisit/0/\(page)")
        case .serials(let page):
            return .get("book/lastupdate/0/\(page)")
        case .complete(let page):
            return .get("book1/0/\(page)")
        case .bookInfo(let uri):
            return .get("xiazai/\(uri)")
        case .catalog(let uri):
            return .get("xiaoshuo/\(uri)")
        }
    }
    
    var params: Parameters? {
        return nil
    }
}
