//
//  yxlw.swift
//  BY
//
//  Created by zuoan on 7/14/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class yxlw: UIViewController {

    @IBOutlet weak var yxlwWebView: UIWebView!
    func loadUrl(url:String)
    {
        let urlobj = NSURL(string:url)
        
        let request = NSURLRequest(URL:urlobj!)
        
        yxlwWebView.loadRequest(request);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.loadUrl("http://bykt.buaa.edu.cn:81/thesis.aspx")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
