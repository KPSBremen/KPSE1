//
//  PatientProfileViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 27/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class PatientProfileViewController: UIViewController {

    var passName = "Martha"
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var patientName: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Draws straight line in Header of the PatientList Table
        let line = UIView(frame: CGRect(x: 0, y: 50, width: 700, height: 1))
        line.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
        self.view.addSubview(line)

        profileName.text = passName
        patientName.setTitle(passName, forState: .Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "patientBriefInfo")
        {
            let controller = segue.destinationViewController as! PatientBreifInfoViewController
            
            controller.passName = passName
        }
        else if (segue.identifier == "PatientProfileToPatientDetail"){
            let controller = segue.destinationViewController as! PatientDeatilsViewController
            
            controller.Name = passName
        }
    }
}
