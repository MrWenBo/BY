//
//  MyClassroomViewController.swift
//  BY
//
//  Created by zuoan on 8/10/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit
import CoreLocation

class MyClassroomViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate {
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    let locationManager = CLLocationManager()//实例化一个CLLocationManager对象
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var tb: UITableView!

    
    
    var refreshControl = UIRefreshControl()
    var reflash = Reflash()
    
    let kcNow_data = NSUserDefaults.standardUserDefaults().valueForKey("kcNow_data")
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    var kcid = ["kcid"]
    var place = ["place"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setInformation()
        
//        location.text = "欢迎：\(userName!)"
        
        refreshControl.addTarget(self, action: "refreshData",
            forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tb.addSubview(refreshControl)
        refreshData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        reflash.getHistoryInfo()
        reflash.getNowInfo()
        reflash.getOpenInfo()
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
//        let boyaView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//        let boyaViewNiv = UINavigationController(rootViewController: boyaView)
//        self.presentViewController(boyaViewNiv, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyclassroomTabelViewCell
        Cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        Cell.name.text = cellName[indexPath.row + 1]
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        Cell.courseid.text = kcid[indexPath.row + 1]
        Cell.classroom.text = place[indexPath.row + 1]
        return Cell
    }
    
    

    
    
    func setInformation(){
        if kcNow_data != nil {
            for item in kcNow_data as! Array<AnyObject> {
                cellName.append(item.valueForKey("kc_name") as! String)
                teacher.append(item.valueForKey("kc_teacher") as! String)
                school.append(item.valueForKey("kc_host") as! String)
                date.append(item.valueForKey("kc_date") as! String)
                kcid.append(item.valueForKey("kc_id") as! String)
                place.append(item.valueForKey("kc_place") as! String)
            }
        }    
    }
    @IBAction func liftView(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)

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
            deleteCourse(kcid[indexPath.row + 1])
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyclassroomTabelViewCell
        
        let message = cellName[indexPath.row + 1]
        
        let myAlert = UIAlertController(title: "课程操作", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let inAction = UIAlertAction(title: "上课签到", style: .Default) { (UIAlertAction) -> Void in
            
            print("signIn")
            self.signIn(self.kcid[indexPath.row+1], longitude: String(self.longitude) , latitude: String(self.latitude))
//            Cell.place.text = "经度：\(self.latitude)   纬度：\(self.longitude)"
            
        }
        let outAction = UIAlertAction(title: "下课签退", style: .Default) { (UIAlertAction) -> Void in
            
            print("signOut")
            self.signOut(self.kcid[indexPath.row+1], longitude: String(self.longitude) , latitude: String(self.latitude))
            
        }
        let deleteAction = UIAlertAction(title: "是否退课", style: .Default) { (UIAlertAction) -> Void in
            
            print("delete")
            self.deleteCourse(self.kcid[indexPath.row + 1])
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        myAlert.addAction(inAction)
        myAlert.addAction(outAction)
        myAlert.addAction(deleteAction)
        myAlert.addAction(cancelAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    func signIn(id: String,longitude:String,latitude:String){
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/CourseSignIn/signIn")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&course_id=\(id)&longitude=\(longitude)&latitude=\(latitude)&type=0"
        //userid=13211031&courseid=KC1002113126&longitude="123.11"&latitude="36"
        //        let postString = "userid=13211031&password=123"
        locationManager.delegate = self  // 设置 delegate 为自身VC
        locationManager.distanceFilter = 20  // 设置只有用户位置移动了 1000m 后才通知代理
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        print(latitude)
        print(longitude)
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let data = jsonData.valueForKey("data")
                
                print(data!)
                
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已经开始上课，签到失败", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "签到未开始", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 3{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "签到成功", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 7{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已签到", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }
                
                
            }catch{}
        }
        
        loginTask.resume()
        
    
    }
    func signOut(id: String,longitude:String,latitude:String){
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/CourseSignIn/signIn")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&course_id=\(id)&longitude=\(longitude)&latitude=\(latitude)&type=1"
        //userid=13211031&courseid=KC1002113126&longitude="123.11"&latitude="36"
        //        let postString = "userid=13211031&password=123"
        locationManager.delegate = self  // 设置 delegate 为自身VC
        locationManager.distanceFilter = 20  // 设置只有用户位置移动了 1000m 后才通知代理
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        print(latitude)
        print(longitude)
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let data = jsonData.valueForKey("data")
                
                print(data!)
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 4{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "超过下课签到时间，签到失败", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }else if dataInt == 5{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "下课签到未开始", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 6{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "下课签到成功", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 7{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已签到", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }

                
                
            }catch{}
        }
        
        loginTask.resume()
        
        
    }
    
    
    
    func deleteCourse(id:String){
        let loginSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://localhost/Boya/index.php/Boya/StudentCourse/deleteCourse")
        let loginRequest = NSMutableURLRequest(URL: url!)
        loginRequest.HTTPMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(id)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.HTTPBody = NSString(string: postString).dataUsingEncoding(NSUTF8StringEncoding)
        
        let loginTask = loginSession.dataTaskWithRequest(loginRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let data = jsonData.valueForKey("data")
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
               
                if dataInt == 0{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "你未选该课程", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }else if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "超出退课时间", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "退课成功", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                }
                
            }catch{}
        }
        
        loginTask.resume()

    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Denied:
            // 这里写被用户拒绝之后运行的代码
            print("用户拒绝")
            break;
        default:
            manager.startUpdatingLocation()
            break;
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let thelocations:NSArray = locations as NSArray
        let location:CLLocation = thelocations.objectAtIndex(0) as! CLLocation
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
        
    }

    
}
