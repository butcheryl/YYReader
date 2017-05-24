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

class BookcaseViewController: BaseViewController, View {
    
    // MARK: property
    let dataSource = RxTableViewSectionedReloadDataSource<BookListViewSection>()
    
    // MARK: UI
    var tableView: UITableView!
    
    init(reactor: BookcaseViewReactor) {
        defer { self.reactor = reactor }
        super.init()
        self.title = "书架"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    func bind(reactor: BookcaseViewReactor) {
        
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
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

