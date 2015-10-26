//
//  ArticlesViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/23.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var book: Book!
    
    @IBOutlet var topToolBar: UIView!
    @IBOutlet var bottomToolBar: UIView!
    
    var pageViewController: UIPageViewController! {
        didSet {
            self.pageViewController.delegate = self
            self.pageViewController.dataSource = self
            self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            
            self.addChildViewController(self.pageViewController)
            self.view.insertSubview(self.pageViewController.view, atIndex: 0)
            self.pageViewController.didMoveToParentViewController(self)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.setViewControllers([UIViewController()], direction: .Forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return self.topToolBar == nil ? true : self.topToolBar.hidden
    }
    
    @IBAction func items_click(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("")
        case 1:
            print("")
        case 2:
            print("")
        case 3:
            print("")
        default:
            break
        }
    }
    
    @IBAction func back_click(sender: AnyObject) {
        self.topToolBar.hidden = !self.topToolBar.hidden
        self.bottomToolBar.hidden = !self.bottomToolBar.hidden
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.redColor()
        return vc
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.greenColor()
        return vc
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
