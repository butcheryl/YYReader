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
    
    init(bookURI uri: String) {
        initialState = State(uri: uri)
        _ = self.state
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            let uri = currentState.uri
            
            let db = Database()
            
            let ts = db.book(where: uri)?.chapters.map { $0.title } ?? []
            
            if ts.count <= 0 {
                return APIs.request(.catalog(uri: uri))
                    .mapHTML()
                    .map({ (doc) -> [Chapter] in
                        return [Chapter]()
                    })
                    .map({
                        let section = SectionModel<String, String>(model: "", items: $0.map{ $0.title })
                        return .setListData([section])
                    })
            } else {
                let section = SectionModel<String, String>(model: "", items: ts)
                return Observable<Mutation>.just(.setListData([section]))
            }
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
