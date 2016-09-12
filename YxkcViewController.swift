//
//  YxkcViewController.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class YxkcViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let userName = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
    let password = NSUserDefaults.standardUserDefaults().stringForKey("password")
    let kcNow_data = NSUserDefaults.standardUserDefaults().valueForKey("kcOpen_data")
    
    var cellName = ["课程列表初始化"]
    var teacher = ["teacher"]
    var school = ["host"]
    var date = ["date"]
    var kcid = ["kcid"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setInformation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! YxkcTableViewCell
        
        //        Cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        //
        //        Cell.textLabel?.text = cellName[indexPath.row + 1]
        //
        //        Cell.textLabel?.font = Cell.textLabel?.font.fontWithSize(20)
        
        
        Cell.teacher.text = teacher[indexPath.row + 1]
        Cell.name.text = cellName[indexPath.row + 1]
        Cell.time.text = date[indexPath.row + 1]
        
        
        
        return Cell
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
//        NSString *rowString = [self.list objectAtIndex:[indexPath row]];
//        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
        let myAlert = UIAlertController(title: "⚠️ 警告", message: "用户名或密码未填写", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
    
    
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
