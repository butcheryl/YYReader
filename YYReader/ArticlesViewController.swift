//
//  ArticlesViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/23.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import Ono
import UIKit
import Alamofire
import SVProgressHUD

class ArticlesViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var book: Book!
    
    @IBOutlet weak var topToolBar: UIView!
    @IBOutlet weak var bottomToolBar: UIView!
    @IBOutlet weak var header: UILabel!
    
    lazy var pageViewController: UIPageViewController! = {
        var pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        pageViewController.setViewControllers([UIViewController()], direction: .Forward, animated: true, completion: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        return pageViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        
        self.addChildViewController(self.pageViewController)
        self.view.insertSubview(self.pageViewController.view, atIndex: 0)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.load_catalogue()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:"background_click:"))
    }

    func load_catalogue() {
        var catalogues = [(uri: String, title: String)]()
        SVProgressHUD.show()
        Alamofire.request(.GET, self.book.catalogueURL()).responseHTMLDocument { (response) -> Void in
            if let document = response.result.value {
                // 根据CSS规则检索节点并使用闭包遍历所有检索结果
                document.enumerateElementsWithCSS(".mulu_list", usingBlock: { (element: ONOXMLElement!, _, _) -> Void in
                    for children in element.children as! [ONOXMLElement]! {
                        let aElement = children.firstChildWithTag("a")
                        if aElement != nil {
                            catalogues.append((uri: (aElement["href"] as! String), title: aElement.stringValue()))
                        }
                    }
                })
                
                self.book.catalogues = catalogues
                let vc = ArticlesDetailViewController(url: self.book.chapterURL(0))
                self.pageViewController.setViewControllers([vc], direction: .Forward, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func items_click(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("换源")
        case 1:
            print("缓存")
        case 2:
            
            guard let catalogues = self.book.catalogues where catalogues.count > 0 else {
                // 目录条数为空
                return
            }
            
            let vc = CatalogueListViewController(catalogue: catalogues)
            let navi = UINavigationController(rootViewController: vc)
            self.presentViewController(navi, animated: true, completion: { () -> Void in
                navi.title = self.book.name
            })
            
            
        case 3:
            print("设置")
        default:
            break
        }
    }
    
    @IBAction func backButton_click(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func background_click(sender: AnyObject) {
        self.header.text = self.book.name
        
        self.topToolBar.hidden = !self.topToolBar.hidden
        self.bottomToolBar.hidden = !self.bottomToolBar.hidden
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if self.book.currentChapterNumber == 0 {
            return nil
        } else {
            self.book.currentChapterNumber--
        }
        
        return ArticlesDetailViewController(url: self.book.chapterURL())
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if self.book.currentChapterNumber == self.book.catalogues!.count - 1 {
            return nil
        } else {
            self.book.currentChapterNumber++
        }
        
        return ArticlesDetailViewController(url: self.book.chapterURL())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return self.topToolBar == nil ? true : self.topToolBar.hidden
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
