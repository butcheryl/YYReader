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

struct Book: CustomStringConvertible {
    var name: String
    var author: String
    var category: String
    
    var path: String
    
    init(element: XMLElement) {
        category = (element.firstChild(xpath: "a[1]")?.stringValue ?? "")
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
        
        var temp = element.firstChild(xpath: "text()")?.stringValue ?? ""
        
        if temp.characters.count > 0 && temp.characters.first == "/" {
            temp = temp.substring(from: temp.index(temp.startIndex, offsetBy: 1))
        }
        
        author = temp
        
        name = element.firstChild(xpath: "a[2]")?.stringValue ?? ""
        
        path = element.firstChild(xpath: "a[2]")?.attr("href") ?? ""
    }
    
    var description: String {
        return "name: \(name), author: \(author), category: \(category), path: \(path)"
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        APIs.request(.rank(page: 1))
            .mapHTML()
            .subscribe(onNext: { doc in
                let list = doc.body?.css("div.list p.line")

                list?.forEach({ element in
                    print(Book(element: element))
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

