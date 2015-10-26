//
//  CatalogueListViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/26.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import UIKit

class CatalogueListViewController: UITableViewController {

    var items: [(uri: String, title: String)]!
    
    convenience init(catalogue: [(uri: String, title: String)]) {
        self.init()
        self.items = catalogue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "backButton_click:")
        
        
        
    }
    
    func backButton_click(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true) {}
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 跳转到这一章
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell!.textLabel?.text = "\(self.items[indexPath.row].title)"
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
