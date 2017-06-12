//
//  BookCatalogueReactor.swift
//  YYReader
//
//  Created by butcheryl on 2017/6/1.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import RxDataSources

class BookCatalogueReactor: Reactor {
    enum Action {
        case loadData
        case changeOrder
    }
    
    enum Mutation {
        case setListData([SectionModel<String, String>])
    }
    
    struct State {
        var uri: String
        var sections: [SectionModel<String, String>] = []
        
        init(uri: String) {
            self.uri = uri
        }
    }
    
    let initialState: State
    
    var service: BookService = BookService()
    
    init(bookURI uri: String) {
        initialState = State(uri: uri)
        _ = self.state
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            let uri = currentState.uri
            return service.catalog(uri: uri)
                .map({ $0.enumerated().flatMap({ "\($0+1). \($1.title)" }) })
                .map({ .setListData([SectionModel<String, String>(model: "", items: $0)]) })
        case .changeOrder:
            let items: [String] = (currentState.sections.first?.items ?? []).reversed()
            return .just(.setListData([SectionModel<String, String>(model: "", items: items)]))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setListData(let sections):
            state.sections = sections
        }
        return state
    }
}
