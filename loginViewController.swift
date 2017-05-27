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
    @IBOutlet weak var loginButton: UIButton!
    
    let userNamelogin = UserDefaults.standard.string(forKey: "user_name")
    let passwordlogin = UserDefaults.standard.string(forKey: "password")
    
    
    @IBOutlet weak var login: UILabel!
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    @IBAction func DoneCloseKeyBoard(_ sender: Any) {
        view.resignFirstResponder();
    }

    @IBAction func loginButton(_ sender: AnyObject) {
        
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        if (userName!.isEmpty || password!.isEmpty){
            let myAlert = UIAlertController(title: "提示", message: "用户名或密码未填写", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/LoginAndRegister/Login")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(userNameTextField.text! as String)&password=\(passwordTextField.text! as String)"
//        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
      
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let status = jsonData.value(forKey: "status") as! String
            let result = jsonData.value(forKey: "result") as! String
            print(status)
            print(result)
                
            DispatchQueue.main.async(execute: { () -> Void in
        
            if status == "true" && result == "true"{
                
                UserDefaults.standard.set(userName, forKey: "user_name")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.synchronize()//同步
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.buildUserInterface()

                
            }else{
                let myAlert = UIAlertController(title: "提示", message: "密码或用户名错误", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                print("fail")
            }
            })
        }catch{}
        } 
        loginTask.resume()
    }
}
