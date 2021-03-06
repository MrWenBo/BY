//
//  LiftSideViewController.swift
//  BY
//
//  Created by zuoan on 8/10/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    var kcInfo = [KcInformation]()
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    let kcHistory_data = UserDefaults.standard.value(forKey: "kcHistory_data")
    

    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LiftTableViewCell
        
    
        Cell.name.text = cellName[indexPath.row + 1]
        
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        return Cell
    }
    
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
