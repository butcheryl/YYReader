//
//  BookDetailViewReactor.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxDataSources

final class BookDetailViewReactor: Reactor {
    
    struct State {
        var uri: String
        var bookDetail: Book?
        var sections: [SectionModel<String, String>] = []
        
        init(uri: String) {
            self.uri = uri
        }
    }
    
    enum Action {
        case loadHeaderData
        case loadListData        
        case joinBookcase
    }
    
    enum Mutation {
        case setHeaderData(Book)
        case setListData([SectionModel<String, String>])
    }
    
    var service: BookService = BookService()
    
    var initialState: State
    
    init(bookURI uri: String) {
        self.initialState = State(uri: uri)
        _ = self.state
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadHeaderData:
            return service.book(uri: self.currentState.uri).map({ return Mutation.setHeaderData($0) })
        case .loadListData:
            let section = SectionModel<String, String>(model: "", items: ["查看目录", "开始阅读", "加入书架"])
            return Observable<Mutation>.just(.setListData([section]))
        case .joinBookcase:
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setHeaderData(let book):
            state.bookDetail = book
        case .setListData(let sections):
            state.sections = sections
        }
        
        return state
    }
}
