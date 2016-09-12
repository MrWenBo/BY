//
//  ViewController.swift
//  BY
//
//  Created by zuoan on 7/13/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    @IBOutlet weak var kcxwLabel: UIButton!
    
    @IBOutlet weak var kcygLabel: UIButton!
    
    @IBOutlet weak var msktLabel: UIButton!
    
    @IBOutlet weak var yxlwLabel: UIButton!
    
    @IBOutlet weak var xxzlLabel: UIButton!
    
    @IBAction func kcxwButton(sender: AnyObject) {
    }
    @IBAction func kcygButton(sender: AnyObject) {
    }
    @IBAction func msktLabel(sender: AnyObject) {
    }
    @IBAction func yxlwButton(sender: AnyObject) {
    }
    @IBAction func xxzlButton(sender: AnyObject) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userName != nil{
            self.getHistoryInfo()
            self.getNowInfo()
            self.getOpenInfo()
        }
        
//        self.viewController = ({
//            EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
//            [self.view addSubview:viewController.view];
//            [self addChildViewController:viewController];
//            [viewController didMoveToParentViewController:self];
//            viewController;
//        });
//        let viewController = EFAnimationViewController.init()
//        self.view.addSubview(viewController.view)
//        self.addChildViewController(viewController)
//        viewController.didMoveToParentViewController(self)
//        viewController

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {//雪花效果
        super.viewDidAppear(animated)
        let snowOverlay = VENSnowOverlayView.init(frame: self.view.frame)
        self.view.addSubview(snowOverlay)
        snowOverlay.beginSnowAnimation()
        
    }


    
    
    func getHistoryInfo(){
        
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/getStuHistoryCourseList")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let isnull = jsonData.valueForKey("data")
                
                if isnull! is NSNull{
                    print("没有数据")
                    
                }else{
                    let data = jsonData.valueForKey("data") as! NSArray
                    //                print(data)
                    //NSUserDefaults.standardUserDefaults().setValue(data, forKey: "kc_data")
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: "kcHistory_data")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    //                    print("data is synchronize")
                }
                
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    func getNowInfo(){
        
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/getStuNowCourseList")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                //                    let status = jsonData.valueForKey("status") as! String
                //                    let result = jsonData.valueForKey("result") as! String
                
                let isnull = jsonData.valueForKey("data")
                
                if isnull! is NSNull {
                    print("没有数据")
                    
                }else{
                    let data = jsonData.valueForKey("data") as! NSArray
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: "kcNow_data")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    func getOpenInfo(){
        
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/getOpenCourseList")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let isnull = jsonData.valueForKey("data")
                
                if isnull! is NSNull {
                    print("可选课程没有数据")
                    
                }else{
                    let data = jsonData.valueForKey("data") as! NSArray
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: "kcOpen_data")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
            }catch{}
        }
        
        loginTask.resume()
    }

}


//    @IBAction func myClassroomButton(sender: AnyObject) {
//            let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("MyClassroomViewController") as! MyClassroomViewController
//            self.presentViewController(loginView, animated: true, completion: nil)
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
////            appDelegate.buildUserInterface()//创建抽屉式界面
//            appDelegate.buildInterface()//tab bar
//    }

