//
//  ViewController.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift
import Fuzi

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         
         // http://m.ybdu.com/xiaoshuo/12/12845/
         // http://m.ybdu.com/xiaoshuo/12/12845/3179548.html

        APIs.request(.rank(page: 1))
            .mapHTML()
            .map({ doc -> [Book] in
                doc.body?.css("div.list p.line").map { element in
                    let name = element.firstChild(xpath: "a[2]")?.stringValue ?? ""
                    let uri = (element.firstChild(xpath: "a[2]")?.attr("href") ?? "").replacingOccurrences(of: "/xiazai", with: "")
                    
                    var book = Book()
                    book.uri = uri
                    book.info.name = name
                    return book
                } ?? []
            })
            .subscribe(onNext: { books in
                books.forEach({ (b) in
                    print(b)
                })
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

