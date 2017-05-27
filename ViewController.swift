//
//  ViewController.swift
//  BY
//
//  Created by zuoan on 7/13/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    
    @IBOutlet weak var kcxwLabel: UIButton!
    
    @IBOutlet weak var kcygLabel: UIButton!
    
    @IBOutlet weak var msktLabel: UIButton!
    
    @IBOutlet weak var yxlwLabel: UIButton!
    
    @IBOutlet weak var xxzlLabel: UIButton!
    
//    @IBAction func kcxwButton(sender: AnyObject) {
//    }
//    @IBAction func kcygButton(sender: AnyObject) {
//    }
//    @IBAction func msktLabel(sender: AnyObject) {
//    }
//    @IBAction func yxlwButton(sender: AnyObject) {
//    }
//    @IBAction func xxzlButton(sender: AnyObject) {
//    }
//    
    
    
    @IBAction func loginOutButton(sender: AnyObject) {
        let myAlert = UIAlertController(title: "提示", message: "是否退出登陆", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) -> Void in
            
            UserDefaults.standard.removeObject(forKey: "user_name")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "kcHistory_data")
            UserDefaults.standard.removeObject(forKey: "kcNow_data")
            UserDefaults.standard.removeObject(forKey: "kcOpen_data")
            UserDefaults.standard.removeObject(forKey: "Zxhd_data")
            
            
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            self.present(loginView, animated: true, completion: nil)
            

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
        myAlert.addAction(cancelAction)
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userName != nil{
            self.getHistoryInfo()
            self.getNowInfo()
            self.getOpenInfo()
            //self.getZxhdInfo()
            //self.getXyhdInfo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {//雪花效果
        super.viewDidAppear(animated)
        let snowOverlay = VENSnowOverlayView.init(frame: self.view.frame)
        self.view.addSubview(snowOverlay)
        snowOverlay.beginSnowAnimation()
       
        self.kcxwLabel.snap(into: self.view, direction: DCAnimationDirection.bottom)
        self.kcygLabel.snap(into: self.view, direction: DCAnimationDirection.right)
        self.xxzlLabel.snap(into: self.view, direction: DCAnimationDirection.top)
        self.msktLabel.snap(into: self.view, direction: DCAnimationDirection.left)
        self.yxlwLabel.snap(into: self.view, direction: DCAnimationDirection.top)
    }
    
    //加载历史课程
    func getHistoryInfo(){
        
        let loginSession = URLSession.shared
        let url = NSURL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getStuHistoryCourseList")
        let loginRequest = NSMutableURLRequest(url: url! as URL)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let isnull = jsonData.value(forKey: "data")
                
                if isnull! is NSNull{
                    print("历史选课没有数据")
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    //                print(data)
                    //NSUserDefaults.standardUserDefaults().setValue(data, forKey: "kc_data")
                    UserDefaults.standard.set(data, forKey: "kcHistory_data")
                    UserDefaults.standard.synchronize()
                    //                    print("data is synchronize")
                }
                
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    //加载已选课程
    func getNowInfo(){
        let loginSession = URLSession.shared
        let url = NSURL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getStuNowCourseList")
        let loginRequest = NSMutableURLRequest(url: url! as URL)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                //                    let status = jsonData.valueForKey("status") as! String
                //                    let result = jsonData.valueForKey("result") as! String
                
                let isnull = jsonData.value(forKey: "data")
                
                if isnull! is NSNull {
                    print("已选没有数据")
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    UserDefaults.standard.set(data, forKey: "kcNow_data")
                    UserDefaults.standard.synchronize()
                }
                
            }catch{}
        }  
        loginTask.resume()
    }
    
    //加载可选课程
    func getOpenInfo(){
        
        let loginSession = URLSession.shared
        let url = NSURL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getOpenCourseList")
        let loginRequest = NSMutableURLRequest(url: url! as URL)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let isnull = jsonData.value(forKey: "data")
                if isnull! is NSNull {
                    print("可选课程没有数据")
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    UserDefaults.standard.set(data, forKey: "kcOpen_data")
                    UserDefaults.standard.synchronize()
                }
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    //加载自选活动
    func getZxhdInfo() {
        let loginSession = URLSession.shared
        let url = NSURL(string: "http://10.254.20.163/Boya/index.php/Boya/CollegeActivityManage/getCollegeActivityList")
        let loginRequest = NSMutableURLRequest(url: url! as URL)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let isnull = jsonData.value(forKey: "data")
                
                if isnull! is NSNull {
                    print("自选活动没有数据")
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    UserDefaults.standard.set(data, forKey: "Zxhd_data")
                    UserDefaults.standard.synchronize()
                }
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    
    func getXyhdInfo() {
        let loginSession = URLSession.shared
        let url = NSURL(string: "http://10.254.20.163/Boya/index.php/Boya/CollegeActivityManage/getCollegeActivityList")
        let loginRequest = NSMutableURLRequest(url: url! as URL)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let isnull = jsonData.value(forKey: "data")
                
                if isnull! is NSNull {
                    print("自选活动没有数据")
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    UserDefaults.standard.set(data, forKey: "Xyhd_data")
                    UserDefaults.standard.synchronize()
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

