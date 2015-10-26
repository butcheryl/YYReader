//
//  YYGlobalConst.swift
//  YYReader
//
//  Created by Butcher on 15/10/26.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import UIKit


let kContentEncoding = YYGlobalConst.contentEncoding

class YYGlobalConst {
    static let contentEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
}
