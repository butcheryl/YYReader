//
//  HTMLResponseSerializer.swift
//  YYReader
//
//  Created by Butcher on 15/10/26.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import Ono
import Alamofire
import Foundation

extension Request {
    public static func HTMLResponseSerializer() -> ResponseSerializer<ONOXMLDocument, NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            
            guard let validData = data else {
                let failureReason = "Data could not be serialized. Input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }

            // 将gbk编码的data转换成UTF-8的字符串
            let content = NSString(data: validData, encoding: kContentEncoding) as? String
            guard let validContent = content else {
                let failureReason = "Data could not be serialized. Convert data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            do {
                // 创建 document
                let HTML = try ONOXMLDocument(string: validContent, encoding: NSUTF8StringEncoding)
                return .Success(HTML)
            } catch {
                return .Failure(error as NSError)
            }
        }
    }
    
    public func responseHTMLDocument(completionHandler: Response<ONOXMLDocument, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.HTMLResponseSerializer(), completionHandler: completionHandler)
    }
}
