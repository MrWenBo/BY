//
//  YxkcTableViewCell.swift
//  BY
//
//  Created by zuoan on 9/7/16.
//  Copyright © 2016 zuoan. All rights reserved.
//

import UIKit

class YxkcTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var teacher: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
