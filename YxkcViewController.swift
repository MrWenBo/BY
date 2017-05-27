//
//  YxkcViewController.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class YxkcViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellName.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
//        NSString *rowString = [self.list objectAtIndex:[indexPath row]];
//        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
        let myAlert = UIAlertController(title: "⚠️ 提示", message: "用户名或密码未填写", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
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
}
