//
//  BookDetailHeaderViewReactor.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import ReactorKit

final class BookDetailHeaderViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var coverURL: URL?
        var name: String
        var category: String
        var author: String
        var desc: String
    }
    
    let initialState: State
    
    init(book: Book) {
        
        var desc = book.desc ?? ""
        
        if desc.characters.count == 0 {
            desc = "暂无简介"
        } else  {
            desc = desc.replacingOccurrences(of: "&nbsp", with: " ")
        }
        
        self.initialState = State(
            coverURL: URL(string: book.cover ?? ""),
            name: book.name,
            category: book.category ?? "未知",
            author: book.author ?? "未知",
            desc: desc
        )
        
        _ = self.state
    }
}
