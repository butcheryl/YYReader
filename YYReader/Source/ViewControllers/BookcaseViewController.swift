//
//  BookcaseViewController.swift
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

class BookcaseViewController: UIViewController, View {
    
    // MARK: property
    let dataSource = RxTableViewSectionedReloadDataSource<BookListViewSection>()
    
    // MARK: UI
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        reactor?.state.map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.

    }
    

    func bind(reactor: BookcaseViewReactor) {
        
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
        
        rx.viewDidLoad.map({ Reactor.Action.refresh }).bind(to: reactor.action).disposed(by: disposeBag)
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

extension BookcaseViewController: UITableViewDelegate {
    
}

