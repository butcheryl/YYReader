//
//  BookstoreViewController.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources
import Then
import MJRefresh

class BookstoreViewController: BaseViewController, View {

    // MARK: property
    let dataSource = RxTableViewSectionedReloadDataSource<BookListViewSection>()
    
    // MARK: UI
    let tableView: UITableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.backgroundColor = .clear
        $0.register(BookstoreListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    init(reactor: BookstoreViewReactor) {
        defer { self.reactor = reactor }
        super.init()
        self.title = "书城"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] _ in
            self?.reactor?.action.onNext(Reactor.Action.refresh)
        })
        
        tableView.mj_footer = MJRefreshAutoStateFooter(refreshingBlock: { [weak self] _ in
            self?.reactor?.action.onNext(Reactor.Action.loadMore)
        })
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bind(reactor: BookstoreViewReactor) {
        dataSource.configureCell = { dataSource, tb, ip, item in
            switch item {
            case .bookcase(let reactor):
                let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: ip) as! BookstoreListTableViewCell
                cell.reactor = reactor
                return cell
            }
        }
        
        tableView.rx.modelSelected(BookListViewSectionItem.self)
            .map { item -> Book in
                switch item {
                case .bookcase(let reactor):
                    return reactor.book
                }
            }
            .subscribe(onNext: { [weak self] book in
                guard let `self` = self else { return }
                
                let reactor = BookDetailViewReactor(bookURI: book.uri)
                
                let vc = BookDetailViewController(reactor: reactor)
                vc.hidesBottomBarWhenPushed = true
                vc.title = book.name
                
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        // Action
        rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map({ $0.refreshState })
            .distinctUntilChanged()
            .subscribe(onNext: { refreshState in
                if refreshState == .headerEnd {
                    self.tableView.mj_header.endRefreshing()
                } else if refreshState == .footerEnd {
                    self.tableView.mj_footer.endRefreshing()
                } else if refreshState == .noMoreData {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                } else if refreshState == .reset {
                    self.tableView.mj_footer.resetNoMoreData()
                }
            })
            .disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
