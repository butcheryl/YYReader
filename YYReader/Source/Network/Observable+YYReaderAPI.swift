//
//  Observable+YYReaderAPI.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Fuzi

extension ObservableType where E == Moya.Response {
    public func mapHTMLString() throws -> Observable<String> {
        
        return map { (response) -> String in
            
            guard let str = String(data: response.data, encoding: String.Encoding(rawValue:CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))) else {
                throw MoyaError.stringMapping(response)
            }
            
            return str
        }
    }
    
    public func mapHTML() -> Observable<HTMLDocument> {
        return map { response in
            try HTMLDocument(data: response.data)
        }
    }
}
