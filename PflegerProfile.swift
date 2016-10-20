//
//  PflegerProfile.swift
//  KPSE1
//
//  Created by Spurti Benakatti on 02/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit
import CoreData



class PflegerProfile: UIViewController  {
    
    let logoutTime = NSDate().toLocalTime()

    @IBOutlet weak var toCalenderList: UIButton!
    @IBOutlet weak var toKeyList: UIButton!
    @IBOutlet weak var toPatientList: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    let currentDate = NSDate().customFormatted       // Current Date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = currentDate
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(PflegerProfile.handleSwipes(_:)))
        
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(rightSwipe)
        view.addSubview(dateLabel)
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
   //On click of Image Pfleger will logout 
    @IBAction func logoutButton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "ACHTUNG LOGOUT" , message: "Wollen Sie sich wirklich vom Dienst abmelden?", preferredStyle: .Alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Ja ich will mich abmelden", style: .Default) { (action) -> Void in
            self.performSegueWithIdentifier("backToStart", sender: self)
        }
        
        let noAction = UIAlertAction(title: "Arbeit fortsetzen", style: .Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let moc = DataController().managedObjectContext
        let user = NSEntityDescription.insertNewObjectForEntityForName("Login", inManagedObjectContext: moc)
        
        user.setValue(logoutTime, forKey: "logout")
        do{
            try moc.save()
        }catch {
            print("There was an error saving data")
        }

        
        //Retreive data
        
        do{
            
            let requset = NSFetchRequest(entityName: "Login")
            requset.returnsObjectsAsFaults = false
            let results = try moc.executeFetchRequest(requset)
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    
                    print("** Pfleger Login Details **")
                    print(item)
                }
            }
        }catch{
            print("Error in Fetching date")
        }
        
        
        
    }
    
    @IBAction func patientlist(sender: AnyObject) {
        toPatientList.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    }
    
    @IBAction func keylist(sender: AnyObject) {
        toKeyList.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    }
       
    @IBAction func calenderlist(sender: AnyObject) {
        toCalenderList.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
       
        if (sender.direction == .Right) {
            print("Swipe Right")
            let calPosition = CGPointMake(self.toCalenderList.frame.origin.x + 100.0, self.toCalenderList.frame.origin.y);
            toCalenderList.frame = CGRectMake( calPosition.x , calPosition.y , self.toCalenderList .frame.size.width, self.toCalenderList.frame.size.height)
            
            let patientlistPosition = CGPointMake(self.toPatientList.frame.origin.x + 50.0, self.toPatientList.frame.origin.y);
            toPatientList.frame = CGRectMake( patientlistPosition.x , patientlistPosition.y , self.toPatientList .frame.size.width, self.toPatientList.frame.size.height)
            
            
            let keylistPosition = CGPointMake(self.toKeyList .frame.origin.x + 50.0, self.toKeyList.frame.origin.y);
            toKeyList.frame = CGRectMake( keylistPosition.x , keylistPosition.y , self.toKeyList .frame.size.width, self.toKeyList.frame.size.height)
        }
    }
      
    
    }
