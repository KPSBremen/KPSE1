//
//  CalenderViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 22/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController , UITableViewDelegate , UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!      //Outlet Connection for Tableview
    
    
    var selectedIndexPath : NSIndexPath? = nil      //Index Path for Table cells
    let selectedCellHeight: CGFloat = 120.0         //Height of the Row on Click
    let unselectedCellHeight: CGFloat = 40.0        // Default Height of the Row
    
    
    var Today  = [Patients]()                       //Array  for CurrentDay
    var Tomorrow = [Patients]()                     // Array for Next Day
    var Yesterday = [Patients]()                    //Array for Previous Day
    
    
    let currentDate = NSDate().customFormatted       // Current Date
    var nextDate: NSDate {return NSCalendar.currentCalendar().dateByAddingUnit(.Day,value: 1, toDate: NSDate(), options: [])!}  //Next Date
    var previousDate: NSDate {return NSCalendar.currentCalendar().dateByAddingUnit(.Day,value: -1, toDate: NSDate(), options: [])!}  //Previous Day date

    
    
    @IBOutlet weak var CalenderSegment: UISegmentedControl!    //Outlet connection for SegmentControl
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Automatic set Title for Segments with Dates
        CalenderSegment.setTitle(previousDate.customFormatted, forSegmentAtIndex: 0)
        CalenderSegment.setTitle(currentDate, forSegmentAtIndex: 1)
        CalenderSegment.setTitle(nextDate.customFormatted, forSegmentAtIndex: 2)
        
        CalenderSegment.backgroundColor = UIColor.clearColor()
        CalenderSegment.removeBorders()
        
     //   let wapon1 = "kalender1"
       // let img = UIImage(named: wapon1)
       
       // CalenderSegment.setBackgroundImage(img , forState: UIControlState , barMetrics: <#T##UIBarMetrics#>)
        // Load data on View
        loadPatientData()
        
        //Delete empty Rows of Table
        tableView.tableFooterView = UIView()
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
        
        //Initialisation of Bremen state Image
        let wapon1 = "bremen"
        let img1 = UIImage(named: wapon1)
        
        //Initialisation of Niedersachsen state Image
        let wapon2 = "Niedersachsen"
        let img2 = UIImage(named: wapon2)
        
        
        // Patients data
        Today = [
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Graif Marta",keynumber : "33" ,adress: "Brüsseler str. 8, 28259 Bremen", patientTel: "0421587328", KlingelImage : photo1 , date : "2016-09-19 19:30", duration: "00:03", time: "16:51 - 16:54" , etage: "3. Etage", aufzug: "Nein", tur: "re.",  relativeName: "Renate Klakus", relativeTel: "0421587328", doctorName: "Christian Funke", doctorTel: "0421582077", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "bla bla bla" )! ]
            
 
        Tomorrow = [
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Graif Marta",keynumber : "33" ,adress: "Brüsseler str. 8, 28259 Bremen", patientTel: "0421587328", KlingelImage : photo1 , date : "2016-09-19 19:30", duration: "00:03", time: "16:51 - 16:54" , etage: "3. Etage", aufzug: "Nein", tur: "re.",  relativeName: "Renate Klakus", relativeTel: "0421587328", doctorName: "Christian Funke", doctorTel: "0421582077", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "bla bla bla" )!]
        
        Yesterday = [
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Graif Marta",keynumber : "33" ,adress: "Brüsseler str. 8, 28259 Bremen", patientTel: "0421587328", KlingelImage : photo1 , date : "2016-09-19 19:30", duration: "00:03", time: "16:51 - 16:54" , etage: "3. Etage", aufzug: "Nein", tur: "re.",  relativeName: "Renate Klakus", relativeTel: "0421587328", doctorName: "Christian Funke", doctorTel: "0421582077", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "bla bla bla" )!]
        
        //Sort the Patients in Table depending on Time of Tasks
        Today.sortInPlace({$0.date.toDateTime().timeIntervalSinceNow < $1.date.toDateTime().timeIntervalSinceNow})
       
        Tomorrow.sortInPlace({$0.date.toDateTime().timeIntervalSinceNow < $1.date.toDateTime().timeIntervalSinceNow})
        
        Yesterday.sortInPlace({$0.date.toDateTime().timeIntervalSinceNow < $1.date.toDateTime().timeIntervalSinceNow})

       
           }
    
         

    //Number of Rows in Table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var returnValue = 0
        
        // Get Total number of Rows for Each Array
        switch CalenderSegment.selectedSegmentIndex {
            
        case 0 :
                returnValue = Yesterday.count
                break
            
        case 1 :
                returnValue = Today.count
                break
        case 2 :
                returnValue = Tomorrow.count
                break
        default:
                break
        }
                return returnValue
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CalenderTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! CalenderTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        
        // Fetches the appropriate meal for the data source layout.
        let yesterday = Yesterday[indexPath.row]
        let today     = Today[indexPath.row]
        let tomorrow = Tomorrow[indexPath.row]


        
        //Convert Images to UIImageView
        let imageView2 = UIImageView(frame: CGRectMake(5, 5, 30, 30))
        imageView2.image = yesterday.wapon
        imageView2.image = today.wapon
        imageView2.image = tomorrow.wapon

        
        
        //Assign values to UITableview Cell from Arrays
        switch CalenderSegment.selectedSegmentIndex {
            
        case 0 : //Load Previous day Data
                cell.patientName.text = yesterday.patientName
                cell.keyNumber.text = yesterday.keynumber
                cell.addSubview(imageView2)
                cell.timeDuration.text = yesterday.time
            
            
                // Converting Date of type String to NSDate
                let myDate = yesterday.date.toDateTime()
                
                // Background color for Patients row depending on Time of the Patients tasks
            
                switch myDate.hour() {
             
                        //Task timing is in Morning
                        case  5,6,7,8 , 9 , 10 , 11 :
                                cell.backgroundColor = UIColor(red:0.74, green:0.74, blue:0.75, alpha:1.0)
                
                        //Task timing is in Afternoon
                        case 12 , 13 , 14 , 15 :
                                cell.backgroundColor = UIColor(red:0.51, green:0.51, blue:0.53, alpha:1.0)
                
                        //Task timing is in Evening
                        case 16 , 17 , 18 , 19 , 20 :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                        //Task timing is in Night
                        case 21 , 22 , 23 ,24, 1 , 2 , 3, 4 :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                
                        default :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                
                }
                
        break
        case 1 :
                cell.patientName.text = today.patientName
                cell.keyNumber.text = today.keynumber
                cell.addSubview(imageView2)
                cell.timeDuration.text = today.time
            
               // Converting Date of type String to NSDate
               let myDate = today.date.toDateTime()
          
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
            
        break
        case 2 :
                cell.patientName.text = tomorrow.patientName
                cell.keyNumber.text = tomorrow.keynumber
                cell.addSubview(imageView2)
                cell.timeDuration.text = tomorrow.time
            
                // Converting Date of type String to NSDate
                let myDate = tomorrow.date.toDateTime()
         
                // Background color for Patients row depending on Time of the Patients tasks
            
            switch myDate.hour() {
                
                        //Task timing is in Morning
                        case  5,6,7,8 , 9 , 10 , 11 :
                                cell.backgroundColor = UIColor(red:0.74, green:0.74, blue:0.75, alpha:1.0)
                
                        //Task timing is in Afternoon
                        case 12 , 13 , 14 , 15 :
                                cell.backgroundColor = UIColor(red:0.51, green:0.51, blue:0.53, alpha:1.0)
                
                        //Task timing is in Evening
                        case 16 , 17 , 18 , 19 , 20 :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                        //Task timing is in Night
                        case 21 , 22 , 23 ,24, 1 , 2 , 3, 4 :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                        default :
                                cell.backgroundColor = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
                
            }
        break
        default:
        break
        }
        
        
        //space between Rows
        cell.contentView.layer.borderWidth = 3.0
        cell.contentView.layer.borderColor = UIColor.whiteColor().CGColor
        
        return cell

    }
    
    
      @IBAction func segmentAction(sender: AnyObject) {
        tableView.reloadData()
    }

    // This function is called before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        if segue.identifier == "backToPflegerProfile" {
            navigationController?.popViewControllerAnimated(true)
        }
        
        else if segue.identifier == "calenderPatientList" {
            let tabBarVC = segue.destinationViewController as! PatientDeatilsViewController
            let cell = sender as! CalenderTableViewCell
            tabBarVC.Name = cell.patientName.text!
            //tabBarVC.passAdress = cell.adress.text!
            
        }
    }

    
}
