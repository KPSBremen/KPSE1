//
//  CalenderTableViewCell.swift
//  KPSE1
//
//  Created by KPSBremen on 22/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class CalenderTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var wapon: UIImageView!
    
    @IBOutlet weak var patientName: UILabel!

    @IBOutlet weak var keyNumber: UILabel!
    
    @IBOutlet weak var klingelImage: UIImageView!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var patientAddress: UILabel!
    
    @IBOutlet weak var LK: UILabel!
    
    @IBOutlet weak var timeDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
