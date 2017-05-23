//
//  Chapter.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import Foundation

struct Paragraph {
    var text: String
}

struct Chapter {
    var number: Int
    var title: String
    var paragraphs: [Paragraph] = []
}


