//
//  RightSideViewController.swift
//  BY
//
//  Created by zuoan on 8/10/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class RightSideViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    
//    let kcOpen_data = UserDefaults.standard.value(forKey: "kcHistory_data")
     let kcOpen_data = UserDefaults.standard.value(forKey: "kcOpen_data")
    
    
    
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
        
        
        refreshControl.addTarget(self, action: #selector(RightSideViewController.refreshData),
            for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tb.addSubview(refreshControl)
        refreshData()
        
        // Do any additional setup after loading the view.
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
        let boyaView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let boyaViewNiv = UINavigationController(rootViewController: boyaView)
        self.present(boyaViewNiv, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RightTableViewCell
        
        
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
                cellName.append(item.value(forKey: "kc_name") as! String)
                teacher.append(item.value(forKey: "kc_teacher") as! String)
                school.append(item.value(forKey: "kc_host") as! String)
                date.append(item.value(forKey: "kc_date") as! String)
                kcid.append(item.value(forKey: "kc_id") as! String)
                place.append(item.value(forKey: "kc_place") as! String)
            }
        }
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
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = cellName[indexPath.row + 1]
        
        let myAlert = UIAlertController(title: "选课？", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) -> Void in
            print("xuanke")
            
            self.addCourse(self.kcid[indexPath.row + 1])
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    func addCourse(_ id: String){
        let loginSession = URLSession.shared
        let url = URL(string: "http://10.254.20.163/Boya/index.php/Boya/StudentCourse/addCourse")
        let loginRequest = NSMutableURLRequest(url: url!)
        loginRequest.httpMethod = "POST"
        let postString = "userid=\(self.userName! as String)&courseid=\(id)"
        loginRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        let loginTask = loginSession.dataTask(with: loginRequest as URLRequest) { (data, response , e) -> Void in
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let data = jsonData.value(forKey: "data")
                print(data!)
                let dataString = data as! String
                let dataInt: Int? = Int(dataString)
                
                if dataInt == 1{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "该课程人数已满", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }else if dataInt == 2{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "已选该课程", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }else if dataInt == 3{
                    let myAlert = UIAlertController(title: "⚠️ 提示", message: "选课成功", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    
                }

                
            }catch{}
        } 
        
        loginTask.resume()
    }

}
