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
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    let kcNow_data = UserDefaults.standard.value(forKey: "kcNow_data")
    
    let locationManager = CLLocationManager()//实例化一个CLLocationManager对象
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var tb: UITableView!

    
    
    var refreshControl = UIRefreshControl()
    var reflash = Reflash()
    
    
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    var kcid = ["kcid"]
    var place = ["place"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        reflash.getHistoryInfo()
        reflash.getNowInfo()
        reflash.getOpenInfo()
    }
    
    func refreshData() {
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
    
    
    @IBAction func backToBoya(_ sender: AnyObject) {
//        let boyaView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//        let boyaViewNiv = UINavigationController(rootViewController: boyaView)
//        self.presentViewController(boyaViewNiv, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyclassroomTabelViewCell
        Cell.selectionStyle = UITableViewCellSelectionStyle.blue
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
                cellName.append(item.value(forKey: "kc_name") as! String)
                teacher.append(item.value(forKey: "kc_teacher") as! String)
                school.append(item.value(forKey: "kc_host") as! String)
                date.append(item.value(forKey: "kc_date") as! String)
                kcid.append(item.value(forKey: "kc_id") as! String)
                place.append(item.value(forKey: "kc_place") as! String)
            }
        }    
    }
    @IBAction func liftView(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerController?.toggle(MMDrawerSide.left, animated: true, completion: nil)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cellName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteCourse(kcid[indexPath.row + 1])
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyclassroomTabelViewCell
        
        let message = cellName[indexPath.row + 1]
        
        let myAlert = UIAlertController(title: "课程操作", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let inAction = UIAlertAction(title: "上课签到", style: .default) { (UIAlertAction) -> Void in
            
            print("signIn")
            self.signIn(self.kcid[indexPath.row+1], longitude: String(self.longitude) , latitude: String(self.latitude))
//            Cell.place.text = "经度：\(self.latitude)   纬度：\(self.longitude)"
            
        }
        let outAction = UIAlertAction(title: "下课签退", style: .default) { (UIAlertAction) -> Void in
            
            print("signOut")
            self.signOut(self.kcid[indexPath.row+1], longitude: String(self.longitude) , latitude: String(self.latitude))
            
        }
        let deleteAction = UIAlertAction(title: "是否退课", style: .default) { (UIAlertAction) -> Void in
            
            print("delete")
            self.deleteCourse(self.kcid[indexPath.row + 1])
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        myAlert.addAction(inAction)
        myAlert.addAction(outAction)
        myAlert.addAction(deleteAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    func signIn(_ id: String,longitude:String,latitude:String){
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/CourseSignIn/signIn")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&course_id=\(id)&longitude=\(longitude)&latitude=\(latitude)&type=0"
        //userid=13211031&courseid=KC1002113126&longitude="123.11"&latitude="36"
        //        let postString = "userid=13211031&password=123"
        locationManager.delegate = self  // 设置 delegate 为自身VC
        locationManager.distanceFilter = 20  // 设置只有用户位置移动了 1000m 后才通知代理
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        print(latitude)
        print(longitude)
        loginRequest.httpBody = postString.data(using: .utf8)
        
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let data = jsonData.value(forKey: "data")
                
                print(data!)
                
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已经开始上课，签到失败", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "签到未开始", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 3{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "签到成功", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 7{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已签到", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }
                
                
            }catch{}
        }
        
        loginTask.resume()
        
    
    }
    func signOut(_ id: String,longitude:String,latitude:String){
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/CourseSignIn/signIn")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&course_id=\(id)&longitude=\(longitude)&latitude=\(latitude)&type=1"
        //userid=13211031&courseid=KC1002113126&longitude="123.11"&latitude="36"
        //        let postString = "userid=13211031&password=123"
        locationManager.delegate = self  // 设置 delegate 为自身VC
        locationManager.distanceFilter = 20  // 设置只有用户位置移动了 1000m 后才通知代理
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        print(latitude)
        print(longitude)
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let data = jsonData.value(forKey: "data")
                
                print(data!)
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 4{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "超过下课签到时间，签到失败", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }else if dataInt == 5{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "下课签到未开始", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 6{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "下课签到成功", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 7{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "已签到", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }

                
                
            }catch{}
        }
        
        loginTask.resume()
        
        
    }
    
    
    
    func deleteCourse(_ id:String){
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/deleteCourse")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(id)"
        //        let postString = "userid=13211031&password=123"
        
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest){ (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let data = jsonData.value(forKey: "data")
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
               
                if dataInt == 0{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "你未选该课程", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }else if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "超出退课时间", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 警告", message: "退课成功", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }
                
            }catch{}
        } 
        
        loginTask.resume()

    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            // 这里写被用户拒绝之后运行的代码
            print("用户拒绝")
            break;
        default:
            manager.startUpdatingLocation()
            break;
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let thelocations:NSArray = locations as NSArray
        let location:CLLocation = thelocations.object(at: 0) as! CLLocation
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
        
    }

    
}
