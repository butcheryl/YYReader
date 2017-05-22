//
//  YYReaderTargetType.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Moya
import MoyaSugar

protocol YYReaderTargetType: SugarTargetType { }

extension YYReaderTargetType {
    var baseURL: URL {
        return URL(string: "http://m.ybdu.com/")!
    }
    
    var url: URL {
        return self.defaultURL
    }
    
    var httpHeaderFields: [String: String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
}

