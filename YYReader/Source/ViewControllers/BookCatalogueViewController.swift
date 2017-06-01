//
//  BookCatalogueViewController.swift
//  YYReader
//
//  Created by butcheryl on 2017/6/1.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import RxDataSources

class BookCatalogueViewController: BaseViewController, View {

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
    
    var tableView: UITableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.backgroundColor = .white
        $0.tableFooterView = UIView()
    }
    
    init(reactor: BookCatalogueReactor) {
        defer { self.reactor = reactor }
        super.init()
        self.title = "目录"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(closeButtonClicked(sender:)))
    }

    func closeButtonClicked(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(reactor: BookCatalogueReactor) {
        
        dataSource.configureCell = { dataSource, tb, ip, item in
            let cell = tb.dequeueReusableCell(withIdentifier: "cell", for: ip)
            cell.textLabel?.text = item
            return cell
        }
        
        rx.viewDidLoad
            .map({ Reactor.Action.loadData })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
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
