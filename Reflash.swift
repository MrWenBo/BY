//
//  Reflash.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class Reflash: NSObject {
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    
    func getHistoryInfo(){
        
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getStuHistoryCourseList")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
            
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
    
    func getNowInfo(){
        
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getStuNowCourseList")
        let loginRequest = NSMutableURLRequest(url: url!)
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
                    print("已选课程没有数据")
                    
                }else{
                    let data = jsonData.value(forKey: "data") as! NSArray
                    UserDefaults.standard.set(data, forKey: "kcNow_data")
                    UserDefaults.standard.synchronize()
                }
                
            }catch{}
        }
        
        loginTask.resume()
    }
    
    func getOpenInfo(){
        
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/getOpenCourseList")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&password=\(self.password! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let isnull = jsonData.value(forKey: "data")
                
                if isnull! is NSNull {
                    print("可选课程没有数据")
                    
                }else{
                    let data = jsonData.value(forKey: "data")
                    UserDefaults.standard.set(data, forKey: "kcOpen_data")
                    UserDefaults.standard.synchronize()
                }
                
            }catch{}
        } 
        
        loginTask.resume()
    }

}
