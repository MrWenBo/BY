//
//  RightTableViewCell.swift
//  BY
//
//  Created by zuoan on 8/16/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var addCourserLabel: UIButton!
    @IBOutlet weak var courseid: UILabel!
    @IBOutlet weak var name: UILabel!
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let kcOpen_data = UserDefaults.standard.value(forKey: "kcOpen_data")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func addCourse(_ sender: AnyObject) {
        
        
        
        
        
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/addCourse")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(self.courseid.text! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                //                    let status = jsonData.valueForKey("status") as! String
                //                    let result = jsonData.valueForKey("result") as! String
                let data = jsonData.value(forKey: "data")
                
                print(data!)
                
            }catch{}
        }
        
        loginTask.resume()
        
    }
}
