//
//  Reflash.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class Reflash: NSObject {
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
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
