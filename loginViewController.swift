//
//  loginViewController.swift
//  BY
//
//  Created by zuoan on 7/18/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userNamelogin = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let passwordlogin = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        if (userName!.isEmpty || password!.isEmpty){
            let myAlert = UIAlertController(title: "⚠️ 警告", message: "用户名或密码未填写", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/LoginAndRegister/Login")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(userNameTextField.text! as String)&password=\(passwordTextField.text! as String)"
//        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
      
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let status = jsonData.valueForKey("status") as! String
            let result = jsonData.valueForKey("result") as! String
            print(status)
            print(result)
                
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.status.text = jsonData.valueForKey("status") as! String
                
            if status == "true" && result == "true"{
//                let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("MyClassroomViewController") as! MyClassroomViewController
//                self.presentViewController(loginView, animated: true, completion: nil)
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
                NSUserDefaults.standardUserDefaults().synchronize()//同步
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.buildUserInterface()

                
            }else{
                let myAlert = UIAlertController(title: "⚠️ 警告", message: "密码或用户名错误", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                print("fail")
            }
                    
                    
            })
            
        }catch{}
            
        }
        loginTask.resume()
        
        
        
    }


}
