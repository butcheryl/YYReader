//
//  Book.swift
//  YYReader
//
//  Created by Butcher on 15/10/23.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import UIKit

class Book: NSObject {
    var uri: String!
    var name: String!
    var author: String!
    
    required init(uri: String!, name: String!, author: String?) {
        self.uri = uri
        self.name = name
        self.author = author
        super.init()
    }
    
    convenience init(uri: String!, name: String!) {
        self.init(uri: uri, name: name, author: nil)
    }
}
