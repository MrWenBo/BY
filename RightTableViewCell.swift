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
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let kcOpen_data = NSUserDefaults.standardUserDefaults().valueForKey("kcOpen_data")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func addCourse(sender: AnyObject) {
        
        
        
        
        
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/addCourse")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(self.courseid.text! as String)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                //                    let status = jsonData.valueForKey("status") as! String
                //                    let result = jsonData.valueForKey("result") as! String
                let data = jsonData.valueForKey("data")
                
                print(data!)
                
            }catch{}
        }
        
        loginTask.resume()
        
    }
}
