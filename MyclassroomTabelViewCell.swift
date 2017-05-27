//
//  MyclassroomTabelViewCell.swift
//  BY
//
//  Created by zuoan on 8/14/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit
import CoreLocation

class MyclassroomTabelViewCell: UITableViewCell, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()//实例化一个CLLocationManager对象
    let userName = UserDefaults.standard.string(forKey: "user_name")
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var courseid: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var classroom: UILabel!
    

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
