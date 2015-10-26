//
//  BookListTableViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/23.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import UIKit
import Ono

class BookListTableViewController: UITableViewController {

    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 抓取网站的数据
        let data = NSData(contentsOfURL: NSURL(string: "http://m.ybdu.com/quanben/1")!)
        
        // 将gbk编码的data转换成UTF-8的字符串
        let str = NSString(data: data!, encoding: CFStringConvertEncodingToNSStringEncoding(0x0632))
        
        // 创建 document
        let document = try? ONOXMLDocument(string: str as! String, encoding: NSUTF8StringEncoding)

        // 解包
        if let document = document {
            // 根据CSS规则检索节点并使用闭包遍历所有检索结果
            document.enumerateElementsWithCSS(".list p", usingBlock: { (element: ONOXMLElement!, _, _) -> Void in
                let bookElement = element.children.first as! ONOXMLElement
                let bookHref = (bookElement["href"] as! String).stringByReplacingOccurrencesOfString("/xiazai", withString: "")
                self.books.append(Book(uri: bookHref, name: bookElement.stringValue(), author: nil))
            })
            self.tableView.reloadData()
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
