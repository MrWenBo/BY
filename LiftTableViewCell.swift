//
//  LiftTableViewCell.swift
//  BY
//
//  Created by zuoan on 8/12/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class LiftTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
