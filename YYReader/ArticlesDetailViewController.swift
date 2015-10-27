//
//  ArticlesDetailViewController.swift
//  YYReader
//
//  Created by Butcher on 15/10/26.
//  Copyright © 2015年 com.butcher. All rights reserved.
//

import Ono
import UIKit
import SnapKit
import Alamofire
import SVProgressHUD

class ArticlesDetailViewController: UIViewController {
    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.lightGrayColor()
        self.view.addSubview(label)
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - 30)
        textView.backgroundColor = UIColor.whiteColor()
        textView.editable = false
        textView.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(textView)
        return textView
    }()
    
    var url: String!

    convenience init(url: String!) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.label.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.height.equalTo(30)
        }
        
        self.textView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.label.snp_bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        // 请求当前章节的内容
        Alamofire.request(.GET, self.url).responseHTMLDocument({ (response) -> Void in
            if let document = response.result.value {
                document.enumerateElementsWithXPath(".//*[@id='nr_title']", usingBlock: { (element:ONOXMLElement!, _, _) -> Void in
                    self.label.text = element.stringValue()
                })
                
                document.enumerateElementsWithXPath(".//*[@id='txt']", usingBlock: { (element:ONOXMLElement!, _, _) -> Void in
                    self.textView.text = element.stringValue()
                })
                SVProgressHUD.dismiss()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
