//
//  TasksTableViewCell.swift
//  KPSE1
//
//  Created by KPSBremen on 07/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleLK: UIImageView!
    
    @IBOutlet weak var LKSubtask1: UIButton!
    
    @IBOutlet weak var LKSubtask2: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
