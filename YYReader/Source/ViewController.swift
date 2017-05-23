//
//  ViewController.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/22.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        BookService().books(category: .xuanhuan, page: 1)
            .subscribe(onNext: { (books) in
                print(books)
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

