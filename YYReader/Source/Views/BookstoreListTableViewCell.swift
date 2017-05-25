//
//  BookstoreListTableViewCell.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

class BookstoreListTableViewCell: UITableViewCell, View {

    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(reactor: BookCellReactor) {
        reactor.state.map { $0.name }
            .bind(to: textLabel!.rx.text)
            .disposed(by: disposeBag)
    }
}
