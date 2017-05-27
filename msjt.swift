//
//  msjt.swift
//  BY
//
//  Created by zuoan on 7/14/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class msjt: UIViewController {

    @IBOutlet weak var msktWebView: UIWebView!
    func loadUrl(_ url:String)
    {
        let urlobj = URL(string:url)
        
        let request = URLRequest(url:urlobj!)
        
        msktWebView.loadRequest(request);
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { () -> Void in
            self.loadUrl("http://www.buaa.edu.cn/")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
