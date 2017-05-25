//
//  String+BoundingRect.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        guard characters.count > 0 else { return 0 }
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil
        )
        
        return boundingBox.height
    }
}
