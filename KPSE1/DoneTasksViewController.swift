//
//  DoneTasksViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 09/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class DoneTasksViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var passName : String!
    
    @IBOutlet weak var patientName: UIButton!
    
    var listOfImages:[UIImage] = [ UIImage(named: "LK1done")!,UIImage(named: "LK2done")! ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delete empty Rows of Table
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Draws straight line in Header of the PatientList Table
        let line = UIView(frame: CGRect(x: 0, y: 60, width: 700, height: 1))
        line.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
        self.view.addSubview(line)
        
        patientName.setTitle(passName, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Number of Sections in Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    //Total number of Rows in Table
    func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfImages.count
        
    }
    
    //Assign data to the Table cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DoneTasksTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! DoneTasksTableViewCell
        
        
        
        cell.LK.image = listOfImages[indexPath.row]
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        
               return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPatientLogout" {
            let tabBarVC = segue.destinationViewController as! PatientLogoutViewController
            tabBarVC.passName = passName
            
        } else if(segue.identifier == "doneTasksToPatientDetails") {
            let tabBarVC = segue.destinationViewController as! PatientDeatilsViewController
            tabBarVC.Name = passName

        }

    }
   

}
