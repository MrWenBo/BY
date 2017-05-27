//
//  Class.swift
//  BY
//
//  Created by zuoan on 8/12/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class KcInformation{
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    
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
}
