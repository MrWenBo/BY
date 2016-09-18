//
//  RightSideViewController.swift
//  BY
//
//  Created by zuoan on 8/10/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class RightSideViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
//    let kcOpen_data = NSUserDefaults.standardUserDefaults().valueForKey("kcHistory_data")
    let kcOpen_data = NSUserDefaults.standardUserDefaults().valueForKey("kcOpen_data")
    
    
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    var kcid = ["kcid"]
    var place = ["place"]
    
    @IBOutlet weak var tb: UITableView!
    var refreshControl = UIRefreshControl()
    var reflash = Reflash()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setInformation()
        
        
        refreshControl.addTarget(self, action: "refreshData",
            forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tb.addSubview(refreshControl)
        refreshData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func refreshData() {
        //        //移除老数据
        //        self.dataArray.removeAll()
        //        //随机添加5条新数据（时间是当前时间）
        //        for _ in 0..<5 {
        //            let atricle = HanggeArticle(title: "新闻标题\(Int(arc4random()%1000))",
        //                createDate: NSDate())
        //            self.dataArray.append(atricle)
        //        }
        reflash.getHistoryInfo()
        reflash.getNowInfo()
        reflash.getOpenInfo()
        self.tb.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backToBoya(sender: AnyObject) {
        let boyaView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let boyaViewNiv = UINavigationController(rootViewController: boyaView)
        self.presentViewController(boyaViewNiv, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RightTableViewCell
        
        
        Cell.name.text = cellName[indexPath.row + 1]
        //Cell.textLabel?.textColor = UIColor.redColor()
        
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        Cell.courseid.text = kcid[indexPath.row + 1]
        Cell.place.text = place[indexPath.row + 1]
        return Cell
    }
    
    func setInformation(){
        if kcOpen_data != nil {
            for item in kcOpen_data as! Array<AnyObject> {
                cellName.append(item.valueForKey("kc_name") as! String)
                teacher.append(item.valueForKey("kc_teacher") as! String)
                school.append(item.valueForKey("kc_host") as! String)
                date.append(item.valueForKey("kc_date") as! String)
                kcid.append(item.valueForKey("kc_id") as! String)
                place.append(item.valueForKey("kc_place") as! String)
            }
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            cellName.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let message = cellName[indexPath.row + 1]
        
        let myAlert = UIAlertController(title: "选课？", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
            print("xuanke")
            
            self.addCourse(self.kcid[indexPath.row + 1])
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    func addCourse(id: String){
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/addCourse")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(id)"
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let data = jsonData.valueForKey("data")
                print(data!)
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "该课程人数已满", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "已选该课程", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 3{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "选课成功", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }

                
            }catch{}
        }
        
        loginTask.resume()
    }

}
