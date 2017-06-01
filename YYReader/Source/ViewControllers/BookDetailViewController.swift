//
//  BookDetailViewController.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/25.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import RxDataSources

class BookDetailViewController: BaseViewController, View {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
    
    var tableView: UITableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.backgroundColor = .white
        $0.tableFooterView = UIView()
    }
    
    init(reactor: BookDetailViewReactor) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func bind(reactor: BookDetailViewReactor) {
        dataSource.configureCell = { dataSource, tb, ip, item in
            let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: ip)
            cell.textLabel?.text = item
            return cell
        }
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                
                switch indexPath.row {
                case 0:
                    let bcReactor = BookCatalogueReactor(bookURI: reactor.currentState.uri)
                    let vc = BookCatalogueViewController(reactor: bcReactor)
                    let navi = UINavigationController(rootViewController: vc)
                    self.present(navi, animated: true, completion: nil)
                    break
                case 1:
                    // push book content view controller
                    break
                case 2:
                    // joining bookcase
                    reactor.action.onNext(.joinBookcase)
                    break
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        rx.viewDidLoad
            .map { Reactor.Action.loadHeaderData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rx.viewDidLoad
            .map { Reactor.Action.loadListData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.bookDetail }
            .filterNil()
            .subscribe(onNext: { [weak self] (book) in
                guard let `self` = self else { return }
                
                let header = BookDetailHeaderView(frame: .zero)
                header.reactor = BookDetailHeaderViewReactor(book: book)
                header.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: BookDetailHeaderView.height(with: book.desc))
                
                self.tableView.tableHeaderView = header
            })
            .disposed(by: disposeBag)
    }
}




