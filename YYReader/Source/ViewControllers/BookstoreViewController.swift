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
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { 
            
        })
        
        tableView.mj_footer = MJRefreshBackFooter(refreshingBlock: { 
            
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
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        dataSource.configureCell = { dataSource, tb, ip, item in
            switch item {
            case .bookcase(let reactor):
                let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: ip)
                
                reactor.state
                    .map({ $0.name })
                    .bind(to: cell.textLabel!.rx.text)
                    .disposed(by: cell.rx_disposeBag)
                
                //                cell.reactor = reactor
                return cell
            }
        }
        
        // Action
        rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
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

extension BookstoreViewController: UITableViewDelegate {
    
}
