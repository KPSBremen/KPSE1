//
//  PatientTableViewCell.swift
//  KPSE1
//
//  Created by Spurti Benakatti on 05/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    //MARK : Properties
    
    //PatientList Table Row Values.
    // It gives detailed information of the Patients.
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var wapon: UIImage!                //Patient's State recognisation Image
    @IBOutlet weak var keynumber: UILabel!            //Patient House Key number
    @IBOutlet weak var patientName: UILabel!          //Patient Name
    @IBOutlet weak var checkButton: UIButton!

    
    @IBOutlet weak var adress: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Google Map direction from  Specified address to Patient address
    
    @IBAction func ShowDirections1(sender: UIButton) {
        
        var urlString = "http://maps.google.com/maps?"
        urlString += "saddr=53.569272,10.007039"
        urlString += "&daddr=53.078390,8.796710"
     
        if let url = NSURL(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!){
            
            UIApplication.sharedApplication().openURL(url)
        } //End of If statement
        
        
    } // End of ShowDirection function

}
