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
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    let kcHistory_data = NSUserDefaults.standardUserDefaults().valueForKey("kcHistory_data")
    

    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInformation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LiftTableViewCell
        
    
        Cell.name.text = cellName[indexPath.row + 1]
        
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        return Cell
    }
    
    func setInformation(){
        if kcHistory_data != nil{
            for item in kcHistory_data as! Array<AnyObject> {
                cellName.append(item.valueForKey("kc_name") as! String)
                teacher.append(item.valueForKey("kc_teacher") as! String)
                school.append(item.valueForKey("kc_host") as! String)
                date.append(item.valueForKey("kc_date") as! String)
            }
        }
      
    }
}
