//
//  BookstoreViewReactor.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class BookstoreViewReactor: Reactor {
    enum Action {
        case refresh
        case loadMore
    }
    
    enum Mutation {
        case setBooks([Book])
    }
    
    struct State {
        var sections: [BookListViewSection] = [.bookcase([])]
    }
    
    let initialState = State()
    
    let service: BookService = BookService()
    
    init() {
        _ = self.state
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.service.books(category: .chuanyue, page: 1).map({ return .setBooks($0) })
        default:
            break
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setBooks(books):
            let items = books.map(BookCellReactor.init).map(BookListViewSectionItem.bookcase)
            state.sections = [.bookcase(items)]
            return state
        }
    }
}

