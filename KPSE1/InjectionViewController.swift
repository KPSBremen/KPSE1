//
//  InjectionViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 17/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class InjectionViewController: UIViewController {
    
     var passName : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToTasksView" {
            let controller = segue.destinationViewController as! TasksViewController
            controller.passName = passName
        }
    }
}
