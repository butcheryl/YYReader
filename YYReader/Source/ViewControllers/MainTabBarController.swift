//
//  MainTabBarController.swift
//  YYReader
//
//  Created by butcheryl on 2017/5/23.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit

class MainTabBarController: UITabBarController, View {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        defer { reactor = MainTabBarViewReactor() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defer { reactor = MainTabBarViewReactor() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bind(reactor: MainTabBarViewReactor) {
        reactor.state
            .subscribe(onNext: { [weak self] (state) in
                guard let `self` = self else { return }
                
                guard let vc1 = (self.viewControllers?.first as? UINavigationController)?.viewControllers.first as? BookcaseViewController else {
                    return
                }
                
                vc1.reactor = state.bookcaseViewReactor
                
                guard let vc2 = (self.viewControllers?.last as? UINavigationController)?.viewControllers.first as? BookstoreViewController else {
                    return
                }
                
                vc2.reactor = state.bookstoreViewReactor
            })
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
