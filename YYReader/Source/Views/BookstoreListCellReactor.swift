//
//  BookstoreListCellReactor.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import ReactorKit

final class BookCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var name: String
    }
    
    let book: Book
    
    let initialState: State
    
    init(book: Book) {
        self.book = book
        self.initialState = State(name: book.name)
        _ = self.state
    }
}
