//
//  PatientBreifInfoViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 07/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class PatientBreifInfoViewController: UIViewController  {
    
    var passName : String!

    @IBOutlet weak var patientName: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Draws straight line in Header of the PatientList Table
        let line = UIView(frame: CGRect(x: 0, y: 60, width: 700, height: 1))
        line.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
        self.view.addSubview(line)
        
       // setName(passName)

        patientName.setTitle(passName, forState: .Normal)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toTasks")
        {
            let controller = segue.destinationViewController as! TasksViewController
            
            
            controller.passName = passName
        }
        else if (segue.identifier == "PatientInfoToPatientDetailView") {
            let controller = segue.destinationViewController as! PatientDeatilsViewController
            //controller.delegate = self
            
            controller.Name = passName
            
        }
    }
    
    

}
