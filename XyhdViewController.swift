//
//  XyhdViewController.swift
//  BY
//
//  Created by zuoan on 08/05/2017.
//  Copyright © 2017 zuoan. All rights reserved.
//

import UIKit

class XyhdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    let kcHistory_data = UserDefaults.standard.value(forKey: "kcHistory_data")
    
    
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        self.setInformation()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! XyhdTableViewCell
        
        
        Cell.name.text = cellName[indexPath.row + 1]
        
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        return Cell
    }
    
//    func setInformation(){
//        if Zxhd_data != nil{
//            for item in Zxhd_data as! Array<AnyObject> {
//                cellName.append(item.value(forKey: "activity_name") as! String)
//                teacher.append(item.value(forKey: "activity_place") as! String)
//                school.append(item.value(forKey: "activity_place") as! String)
//                date.append(item.value(forKey: "activity_begin_date") as! String)
//            }
//        }
//        
//    }
    
    func setInformation(){
        if kcHistory_data != nil{
            for item in kcHistory_data as! Array<AnyObject> {
                cellName.append(item.value(forKey: "kc_name") as! String)
                teacher.append(item.value(forKey: "kc_teacher") as! String)
                school.append(item.value(forKey: "kc_host") as! String)
                date.append(item.value(forKey: "kc_date") as! String)
            }
        }
        
    }

}
