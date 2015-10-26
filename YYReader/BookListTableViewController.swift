//
//  BookListTableViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/23.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import SVProgressHUD
import Alamofire
import UIKit
import Ono

class BookListTableViewController: UITableViewController {

    var books = [Book]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        Alamofire.request(.GET, "http://m.ybdu.com/quanben/1").responseHTMLDocument { (response) -> Void in
            if let document = response.result.value {
                // 根据CSS规则检索节点并使用闭包遍历所有检索结果
                document.enumerateElementsWithCSS(".list p", usingBlock: { (element: ONOXMLElement!, _, _) -> Void in
                    let bookElement = element.children.first as! ONOXMLElement
                    let bookHref = (bookElement["href"] as! String).stringByReplacingOccurrencesOfString("/xiazai", withString: "")
                    self.books.append(Book(uri: bookHref, name: bookElement.stringValue(), author: nil))
                })
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.books[indexPath.row].name

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
        
        let vc = segue.destinationViewController as! ArticlesViewController
        vc.book = self.books[indexPath.row]
    }
}

