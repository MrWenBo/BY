//
//  MyClassroomTableViewController.swift
//  BY
//
//  Created by zuoan on 8/19/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class MyClassroomTableViewController: UITableViewController {
    
    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    
    
    @IBOutlet weak var location: UILabel!
    
    let kcNow_data = NSUserDefaults.standardUserDefaults().valueForKey("kcNow_data")
    //let kcNow_data = NSUserDefaults.standardUserDefaults().valueForKey("kcHistory_data")//测试
    
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    var kcid = ["kcid"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInformation()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return cellName.count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.tableView.setEditing(true, animated: true)
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyclassroomTabelViewCell
    
        
        Cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        Cell.textLabel?.text = cellName[indexPath.row + 1]
                
        Cell.textLabel?.font = Cell.textLabel?.font.fontWithSize(20)
//        Cell.date.opaque = false
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.host.text = school[indexPath.row + 1]
        Cell.date.text = date[indexPath.row + 1]
        Cell.courseid.text = kcid[indexPath.row + 1]
        
        
        return Cell
    }
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            print("delete")
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    
    func setInformation(){
        if kcNow_data != nil {
            for item in kcNow_data as! Array<AnyObject> {
                cellName.append(item.valueForKey("kc_name") as! String)
                teacher.append(item.valueForKey("kc_teacher") as! String)
                school.append(item.valueForKey("kc_host") as! String)
                date.append(item.valueForKey("kc_date") as! String)
                kcid.append(item.valueForKey("kc_id") as! String)
            }
        }
    }

}
