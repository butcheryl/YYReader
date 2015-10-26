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
    
    var catalogues: [(uri: String, title: String)]?
    
    var currentChapterNumber: Int = 0
    
    required init(uri: String!, name: String!, author: String? = nil) {
        self.uri = uri
        self.name = name
        self.author = author
        super.init()
    }
    
    convenience init(uri: String!, name: String!) {
        self.init(uri: uri, name: name, author: nil)
    }
    
    func catalogueURL() -> String! {
        return "http://www.ybdu.com/xiaoshuo" + self.uri
    }
    
    func chapterURL(index: Int = -1) -> String! {
        if index == -1 {
            return self.chapterURL(self.currentChapterNumber)
        }
        
        if index >= self.catalogues?.count {
            return ""
        }
        
        guard let catalogue = self.catalogues?[index] else {
            return ""
        }
        return "http://m.ybdu.com/xiaoshuo" + self.uri + catalogue.uri
    }
    
    func chapterHeader(index: Int = -1) -> String! {
        if index == -1 {
            return self.chapterHeader(self.currentChapterNumber)
        }
        
        if index >= self.catalogues?.count {
            return ""
        }
        
        guard let catalogue = self.catalogues?[index] else {
            return ""
        }
        return catalogue.title
    }
}
