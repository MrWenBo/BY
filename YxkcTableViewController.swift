//
//  YxkcTableViewController.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class YxkcTableViewController: UITableViewController {
    
    let userName = UserDefaults.standard.string(forKey: "user_name")
    let password = UserDefaults.standard.string(forKey: "password")
    let kcNow_data = UserDefaults.standard.value(forKey: "kcOpen_data")
    
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
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! YxkcTableViewCell
        
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
    
    
    
    
    
    func setInformation(){
        if kcNow_data != nil {
            for item in kcNow_data as! Array<AnyObject> {
                cellName.append(item.value(forKey: "kc_name") as! String)
                teacher.append(item.value(forKey: "kc_teacher") as! String)
                school.append(item.value(forKey: "kc_host") as! String)
                date.append(item.value(forKey: "kc_date") as! String)
                kcid.append(item.value(forKey: "kc_id") as! String)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
