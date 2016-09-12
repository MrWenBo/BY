//
//  Class.swift
//  BY
//
//  Created by zuoan on 8/12/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class KcInformation{
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    var kc_name: String
    var kc_id: String
    var kc_type: String
    var kc_teacher: String
    var kc_date: String
    var kc_time: String
    var kc_place: String
    var kc_host: String
    var kc_count: String
    var kc_selcount: String
    var kc_selstartdate: String
    
    
    init?(kc_id: String,kc_name: String,kc_type: String, kc_teacher: String,kc_date: String,kc_time: String,kc_place: String, kc_host: String,kc_count: String,kc_selcount: String,kc_selstartdate: String){
        self.kc_id = kc_id
        self.kc_name = kc_name
        self.kc_teacher = kc_teacher
        self.kc_host = kc_host
        self.kc_type = kc_type
        self.kc_time = kc_time
        self.kc_selstartdate = kc_selstartdate
        self.kc_selcount = kc_selcount
        self.kc_count = kc_count
        self.kc_date = kc_date
        self.kc_place = kc_place
        
        if kc_name.isEmpty {
            return nil
        }
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
                
                if isnull! is NSNull{
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
                
                if isnull! is NSNull{
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
