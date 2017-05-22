//
//  YYReaderParser.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import Fuzi

protocol BookSourceProtocol {
    var name: String { get set }
    
    var url: String { get set }
    
    func info(data: Data) -> [String: String]
    
    func chapter(data: Data) -> [String: String]
}

struct YBDUBookSource: BookSourceProtocol {
    
    var name: String = "全本小说网"
    
    var url: String = "http://m.ybdu.com/"
    
    func info(data: Data) -> [String: String] {
        guard let doc = try? HTMLDocument(data: data) else { return [:] }
        
        let block = doc.body?.css("div.cover div.block").first
        
        let cover = block?.css("div.block_img2 img").first?.attr("src") ?? ""
        
        let name = block?.css("div.block_txt2 h1 a").first?.stringValue ?? ""
        
        let category = ""
        
        let author = ""
        
        return [
            "name": name,
            "author" : author,
            "category" : category,
            "cover" : cover
        ]
    }
    
    func chapter(data: Data) -> [String: String] {
        guard let doc = try? HTMLDocument(data: data) else { return [:] }
        
        guard let txt = doc.xpath("//*[@id=\"txt\"]/text()").first?.stringValue else { return [:] }
        
        return [
            "text": txt
        ]
    }
}

struct Paragraph {
    var text: String
}

struct Chapter {
    var number: Int
    var title: String
    var paragraphs: [Paragraph] = []
}

struct BookInfo {
    var name: String = ""
    
    var author: String?
    var category: String?
    var cover: String?
    
    init() {}
    
    init(name: String, author: String, category: String, cover: String? = nil) {
        self.name = name
        self.cover = cover
        self.author = author
        self.category = category
    }
}

struct Book {
    
    var uri: String = ""
    
    var info: BookInfo! = BookInfo()
    
    var chapters: [Chapter] = []
    
    init() {}
}
