//
//  BookService.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import RxSwift
import Then

protocol BookServiceType {
    
    func books(category: Book.Category, page: Int) -> Observable<[Book]>
    
    func book(uri: String) -> Observable<Book>
    
    func catalog(uri: String) -> Observable<[Chapter]>
}

final class BookService: BookServiceType {
    
    func books(category: Book.Category, page: Int) -> Observable<[Book]> {
        return APIs
            .request(.category(uri: category.uri, page: page))
            .mapHTML()
            .map { doc in
                doc.css("body p.line a.green")
                    .map { element in
                        return Book().with({
                            $0.name = element.stringValue 
                            $0.uri = (element.attr("href") ?? "").replacingOccurrences(of: "/xiazai/", with: "")
                        })
                    } 
            }
    }
    
    func book(uri: String) -> Observable<Book> {
        return APIs.request(.bookInfo(uri: uri))
            .mapHTML()
            .map{ doc in
                let block = doc.body?.css("div.cover div.block").first
                
                let cover = block?.css("div.block_img2 img").first?.attr("src")
                
                let info = block!.css("div.block_txt2 p").map({$0.stringValue})
                
                let name = info[0]
                
                let author = info[1]
                
                let category = info[2]
                
                let desc = doc.body?.css("div.cover div.intro_info").first?.stringValue
                
                return Book().with({
                    $0.cover = cover
                    $0.author = author
                    $0.category = category
                    $0.name = name
                    $0.desc = desc
                })
            }
    }
    
    func catalog(uri: String) -> Observable<[Chapter]> {
        return APIs.request(.catalog(uri: uri))
            .mapHTML()
            .map({ doc in
                return doc.css("body > div.cover > ul > li > a")
                    .enumerated()
                    .map({ Chapter(number: $0, title: $1.stringValue) })
            })
            .filterEmpty()
    }
}
