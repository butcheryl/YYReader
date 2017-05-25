//
//  BookListViewSection.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import RxDataSources
import ReactorKit

enum BookListViewSection {
    case bookcase([BookListViewSectionItem])
}

extension BookListViewSection: SectionModelType {
    var items: [BookListViewSectionItem] {
        switch self {
        case .bookcase(let items): return items
        }
    }
    
    init(original: BookListViewSection, items: [BookListViewSectionItem]) {
        switch original {
        case .bookcase: self = .bookcase(items)
        }
    }
}

enum BookListViewSectionItem {
    case bookcase(BookCellReactor)
}

