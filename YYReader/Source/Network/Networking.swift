//
//  Networking.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import MoyaSugar
import RxSwift
import Moya

struct APIs {
    enum Error: Swift.Error, LocalizedError {
        case jsonMapping
        case statusCode(String)
        
        var errorDescription: String? {
            switch self {
            case .jsonMapping:
                return "格式错误"
            case .statusCode(let str):
                return str
            }
        }
        
        var failureReason: String? {
            return errorDescription
        }
    }
    
    private static let provider = YYReaderAPIProvider<BookTarget>()
    
    public static func request(_ token: BookTarget) -> Observable<Moya.Response> {
        return provider.request(token)
            .filterSuccessfulStatusCodes()//.debug("🌍 APIs Request", trimOutput: false)
    }
}

final class YYReaderAPIProvider<Target: SugarTargetType>: RxMoyaSugarProvider<Target> {
    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        super.init(manager: manager, plugins: plugins)
    }
}
