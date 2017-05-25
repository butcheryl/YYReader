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

enum RefreshState {
    case normal
    case headerEnd
    case footerEnd
    case noMoreData
    case reset
}

final class BookstoreViewReactor: Reactor {
    
    enum Action {
        case refresh
        case loadMore
    }
    
    enum Mutation {
        case setBooks([Book], page: Int)
        case appendBooks([Book], page: Int)
        case setRefreshState(RefreshState)
    }
    
    struct State {
        var page: Int = 1
        var refreshState: RefreshState = .normal
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
            let loadData = self.service.books(category: .chuanyue, page: 1).map({ return Mutation.setBooks($0, page: 1) })
            let refreshEnd = Observable<Mutation>.just(.setRefreshState(.headerEnd))
            let refreshNormal = Observable<Mutation>.just(.setRefreshState(.normal))
            return .concat([loadData, refreshEnd, refreshNormal])
        case .loadMore:
            let nextPage = self.currentState.page + 1
            let loadData = self.service
                .books(category: .chuanyue, page: nextPage)
                .map({ return Mutation.appendBooks($0, page: nextPage) })
            
            let refreshEnd = Observable<Mutation>.just(.setRefreshState(.footerEnd))
            let refreshNormal = Observable<Mutation>.just(.setRefreshState(.normal))
            return .concat([loadData, refreshEnd, refreshNormal])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setBooks(books, page):
            state.page = page
            let items = books.map(BookCellReactor.init).map(BookListViewSectionItem.bookcase)
            state.sections = [.bookcase(items)]
        case let .appendBooks(books, page):
            let sectionItems = state.sections[0].items + books.map(BookCellReactor.init).map(BookListViewSectionItem.bookcase)
            state.sections = [.bookcase(sectionItems)]
            state.page = page + 1
            return state
        case let .setRefreshState(refreshState):
            state.refreshState = refreshState
        }
        return state
    }
}

