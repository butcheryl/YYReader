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
    
    var disposeBag = DisposeBag()
    
    init(reactor: MainTabBarViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
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
                
                let viewController1 = BookcaseViewController(reactor: state.bookcaseViewReactor)
                
                let navi1 = UINavigationController(rootViewController: viewController1)
                
                let viewController2 = BookstoreViewController(reactor: state.bookstoreViewReactor)
                
                let navi2 = UINavigationController(rootViewController: viewController2)
                
                self.viewControllers = [navi1, navi2]
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
