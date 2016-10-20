//
//  PatientLogoutViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 17/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class PatientLogoutViewController: UIViewController {
    
    var passName = String()
    var passAdress = String()
    
    @IBOutlet weak var patientName: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Draws straight line in Header of the PatientList Table
        let line = UIView(frame: CGRect(x: 0, y: 70, width: 700, height: 1))
        line.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
        self.view.addSubview(line)
        
        patientName.setTitle(passName, forState: .Normal)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LogoutQRScreen")
        {
            let controller = segue.destinationViewController as! LogoutQRScanViewController
            
            controller.passName = passName
        }
            
        else if segue.identifier == "backToDoneTasks"
        {
            let controller = segue.destinationViewController as! DoneTasksViewController
            //controller.adress = passAdress
            controller.passName = passName
            
        }
        
    }
    

    
}
