//
//  NextPatientListViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 10/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class NextPatientListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
     var Patient = [Patients]()
    var passName : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPatientData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadPatientData() {
        
        
        //Initialisation of Bell Image
        let imageName1 = "klingeln"
        let photo1 = UIImage(named: imageName1)
        
        //Initialisation of Not to Bell Image
        let imageName2 = "ohneklingeln"
        let photo2 = UIImage(named: imageName2)
        
        
        // Patients data
        
        Patient = [
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Graif Marta",keynumber : "33" ,adress: "Brüsseler str. 8, 28259 Bremen", patientTel: "0421587328", KlingelImage : photo1 , date : "2016-09-19 19:30", duration: "00:03", time: "16:51 - 16:54" , etage: "3. Etage", aufzug: "Nein", tur: "re.",  relativeName: "Renate Klakus", relativeTel: "0421587328", doctorName: "Christian Funke", doctorTel: "0421582077", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "bla bla bla" )!,
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Schilling Thea",keynumber : "3" ,adress: "Carl-hurtzig-strasse 54 , 28259 Bremen", patientTel: "0421587328", KlingelImage : photo2 , date : "2016-09-19 19:30", duration: "00:05", time: "16:59 - 17:04" , etage: "Erdgegeschoss", aufzug: "Nein", tur: "links",  relativeName: "Marion Schilling", relativeTel: "042121863101", doctorName: "Börger/Wille", doctorTel: "0421576380", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "Marcumar Pat" )!
            
        ]
        
        //Sort the Patients in Table depending on Time of Tasks
        Patient.sortInPlace({$0.date.toDateTime().timeIntervalSinceNow < $1.date.toDateTime().timeIntervalSinceNow})
        
            }
    
    
    
    //Number of Sections in Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    //Total number of Rows in Table
    func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Patient.count
        
    }
    
    //Assign data to the Table cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PatientTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! PatientTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let patient = Patient[indexPath.row]
        
        //Convert Images to UIImageView
        let imageView2 = UIImageView(frame: CGRectMake(5, 5, 30, 30))
        imageView2.image = patient.wapon
        
        
        
        //Fetch the data from Array to Row the Table
        cell.addSubview(imageView2)
        cell.patientName.text = patient.patientName
        cell.keynumber.text = patient.keynumber
        cell.duration.text = patient.time
        cell.adress.text = patient.adress
        cell.checkButton.setImage(UIImage(named: "checkbutton"), forState: .Normal)
        cell.checkButton.setImage(UIImage(named: "checkbutton"), forState: .Highlighted)
       // cell.checkButton.backgroundColor = UIColor.clearColor()
        
        
        //space between Rows
        cell.contentView.layer.borderWidth = 3.0
        cell.contentView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        // Converting Date of type String to NSDate
        let myDate = patient.date.toDateTime()
        
        
        
        // Background color for Patients row depending on Time of the Patients tasks
        
        switch myDate.hour() {
            
            
        //Task timing is in Morning
        case  5,6,7,8 , 9 , 10 , 11 :
            cell.backgroundColor = UIColor(red:0.74, green:0.85, blue:0.84, alpha:1.0 )
            
        //Task timing is in Afternoon
        case 12 , 13 , 14 , 15 :
            cell.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
            
        //Task timing is in Evening
        case 16 , 17 , 18 , 19 , 20 :
            cell.backgroundColor = UIColor(red:0.26, green:0.41, blue:0.47, alpha:1.0 )
            
        //Task timing is in Night
        case 21 , 22 , 23 ,24, 1 , 2 , 3, 4 :
            cell.backgroundColor = UIColor(red:0.26, green:0.41, blue:0.47, alpha:1.0 )
            
            
        default :
            
            cell.backgroundColor = UIColor(red:0.26, green:0.41, blue:0.47, alpha:1.0 )
            
        }
        
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        selectedCell.contentView.backgroundColor = UIColor.grayColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "backToDonetasks"){
            let tabBarVC = segue.destinationViewController as! DoneTasksViewController
            tabBarVC.passName = passName
        }
    }
    }



