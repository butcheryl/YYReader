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
    typealias Action = NoAction
    
    typealias Mutation = NoMutation
    
    struct State {}
    
    let initialState = State()
}
