//
//  BookDetailHeaderView.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Kingfisher

class BookDetailHeaderView: UIView, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    lazy var cover: UIImageView = UIImageView(frame: .zero).then {
        $0.backgroundColor = .lightGray
    }
    
    lazy var nameLabel: UILabel = UILabel(frame: .zero)
    lazy var categoryLabel: UILabel = UILabel(frame: .zero)
    lazy var authorLabel: UILabel = UILabel(frame: .zero)
    lazy var descLabel: UILabel = UILabel(frame: .zero).then {
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(100)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(cover.snp.right).offset(10)
            make.right.equalToSuperview()
        }
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview()
        }
        
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview()
        }
        
        addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(cover.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: BookDetailHeaderViewReactor) {
        
        reactor.state.map { $0.coverURL }
            .filterNil()
            .bind { (url) in
                let r = ImageResource(downloadURL: url)
                self.cover.kf.setImage(with: r)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.name }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.author }
            .bind(to: authorLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.category }
            .bind(to: categoryLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.desc }
            .bind(to: descLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    static func height(with desc: String?) -> CGFloat {
        let descHeight = (desc ?? "").height(withConstrainedWidth: UIScreen.main.bounds.width - 10, font: UIFont.systemFont(ofSize: 17))
        
        return descHeight + 120
    }
}

