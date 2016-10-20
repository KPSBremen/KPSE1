//
//  TasksViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 07/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit



class TasksViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var passName : String!
    var selectedIndexPath : NSIndexPath? = nil
    let selectedCellHeight: CGFloat = 250.0         //Height of the Row on Click
    let unselectedCellHeight: CGFloat = 90.0        // Default Height of the Row
   

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var patientName: UIButton!
    
    
    
    var listOfImages:[UIImage] = [ UIImage(named: "LK1")!,UIImage(named: "LK2")! ]
    
    
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
        let cellIdentifier = "TasksTableViewCelll"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! TasksTableViewCell
        
         
        
       cell.titleLK.image = listOfImages[indexPath.row]
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let whiteRoundedView : UIView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 18, 149))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.8])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        return cell
    }
    

    //Increase the Height of the Row when selected
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedIndexPath == indexPath {
            return selectedCellHeight
        }
        return unselectedCellHeight
    }
    
   
    //Selection of the Row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        if selectedIndexPath != nil && selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
            
            
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
    }

   
  /*  @IBAction func backButton(sender: AnyObject) {
        delegate!.setName(passName)
        self.navigationController?.popViewControllerAnimated(true)
    } */
    // This function is called before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDoneTasks" {
            let tabBarVC = segue.destinationViewController as! DoneTasksViewController
            tabBarVC.passName = passName
            
        } else if(segue.identifier == "tasksToPatientDetails"){
            let tabBarVC = segue.destinationViewController as! PatientDeatilsViewController
            tabBarVC.Name = passName
        } else if(segue.identifier == "backToPatientBriefInfo"){
            let tabBarVC = segue.destinationViewController as! PatientBreifInfoViewController
            tabBarVC.passName = passName
        } else if (segue.identifier == "toInjectionView"){
            let tabBarVC = segue.destinationViewController as! InjectionViewController
            tabBarVC.passName = passName
        }
        
        
    }

}
