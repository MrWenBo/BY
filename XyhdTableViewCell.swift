//
//  XyhdTableViewCell.swift
//  BY
//
//  Created by zuoan on 08/05/2017.
//  Copyright © 2017 zuoan. All rights reserved.
//

import UIKit

class XyhdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var host: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
