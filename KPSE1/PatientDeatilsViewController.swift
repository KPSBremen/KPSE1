//
//  PatientDeatilsViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 05/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PatientDeatilsViewController: UIViewController {

    var Name = String()
    var Patient = [Patients]()
    
    //Location tracking
    var locManager = CLLocationManager()
    var userLat = CLLocationDegrees()           //Pfleger current location Lattitude
    var userlong = CLLocationDegrees()          //Pfleger current location Longitude
    var latitude = String()           //Pfleger current location Lattitude
    var longitude = String()
    var currentAddr = String()
    var destinatinAddr = String()
    //MARK : Outlets 
    
    @IBOutlet weak var patientName: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet weak var adress: UIButton!
    @IBOutlet weak var etage: UILabel!
    @IBOutlet weak var aufzug: UILabel!
    @IBOutlet weak var tür: UILabel!
    @IBOutlet weak var patientTelephone: UIButton!
    @IBOutlet weak var relativeName: UILabel!
    @IBOutlet weak var relativeTelephone: UIButton!
    @IBOutlet weak var doctorname: UILabel!
    @IBOutlet weak var doctorTelephone: UIButton!
    @IBOutlet weak var stateWapon: UIImageView!
    @IBOutlet weak var LKdetail1: UILabel!
    @IBOutlet weak var LKdetail2: UILabel!
    @IBOutlet weak var information1: UILabel!
    @IBOutlet weak var information2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get request for Location access authorization
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation = CLLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            
            currentLocation = locManager.location!
            
        }
        
        userLat = currentLocation.coordinate.latitude
        userlong = currentLocation.coordinate.longitude
        
        currentAddr = String(userLat) + "," + String(userlong)
        print("currenttttttt????????????????")
        print(currentAddr)

        
        //Draws straight line in Header of the PatientList Table
        let line = UIView(frame: CGRect(x: 0, y: 45, width: 700, height: 1))
        line.backgroundColor = UIColor(red:0.40, green:0.57, blue:0.62, alpha:1.0 )
        self.view.addSubview(line)
        
        patientName.setTitle(Name, forState: .Normal)
        
        
        //Initialisation of Bell Image
        let imageName1 = "klingeln"
        let photo1 = UIImage(named: imageName1)
        
        //Initialisation of Not to Bell Image
        let imageName2 = "ohneklingeln"
        let photo2 = UIImage(named: imageName2)
        
        
        // Patients data
        
        Patient = [
            Patients(wapon : UIImage(named: "bremen")!,patientName: "Graif Marta",keynumber : "33" ,adress: "Brüsseler str. 8, 28259 Bremen", patientTel: "421587328", KlingelImage : photo1 , date : "2016-09-19 19:30", duration: "00:03", time: "16:51 - 16:54" , etage: "3. Etage", aufzug: "Nein", tur: "re.",  relativeName: "Renate Klakus", relativeTel: "421587328", doctorName: "Christian Funke", doctorTel: "421582077", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "bla bla bla" )!,
           Patients(wapon : UIImage(named: "bremen")!,patientName: "Schilling Thea",keynumber : "3" ,adress: "Carl-hurtzig-strasse 54 , 28259 Bremen", patientTel: "0049421587328", KlingelImage : photo2 , date : "2016-09-19 19:30", duration: "00:05", time: "16:59 - 17:04" , etage: "Erdgegeschoss", aufzug: "Nein", tur: "links",  relativeName: "Marion Schilling", relativeTel: "42121863101", doctorName: "Börger/Wille", doctorTel: "421576380", LKDetail1: "1 * P11 : Blutzuckermessung", LKDetail2: "1 * P18 : Injektion(subcutane und intramuskuläre", info1: "BZ Protokol 1 * monatlich ins büro zum faxen mitbringen", info2: "Marcumar Pat" )!                  ]
        
        let add = Name
        //Sort the Patients in Table depending on Time of Tasks
        Patient.sortInPlace({$0.date.toDateTime().timeIntervalSinceNow < $1.date.toDateTime().timeIntervalSinceNow})
        
        
        
        //Patient += [patientName1 , patientName2 , patientName3 , patientName4 , patientName5 , patientName6 , patientName7 , patientName8 , patientName9 , patientName10]
        
        for p in Patient {
            if p.patientName == add {
            time.text = p.time
            timeDuration.text = p.duration
            adress.setTitle(p.adress, forState: .Normal)
            etage.text = p.etage
            aufzug.text = p.aufzug
            tür.text = p.tur
            patientTelephone.setTitle(p.patientTel, forState: .Normal)
            relativeName.text = p.relativeName
            relativeTelephone.setTitle(p.relativeTel, forState: .Normal)
            doctorname.text = p.doctorName
            doctorTelephone.setTitle(p.doctorTel, forState: .Normal)
           // stateWapon = p.wapon
            LKdetail1.text = p.LKDetail1
            LKdetail2.text = p.LKDetail2
            information1.text = p.info1
            information2.text = p.info2
                
                let imageView2 = UIImageView(frame: CGRectMake(5, 80, 30, 30))
                imageView2.image = p.wapon
            stateWapon.image = imageView2.image
                
                //Fetch the data from Array to Row the Table
               // cell.addSubview(imageView2)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Actions
    
    @IBAction func googleDirections(sender: UIButton) {
        
        let patientLocationAdress = sender.titleLabel?.text
        
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(patientLocationAdress!,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                
                self.latitude = String((placemark.location?.coordinate.latitude)!)
                self.longitude = String((placemark.location?.coordinate.longitude)!)
               
                //let patientLat = String(latitude)
                //let patientLong = String(longitude)
                
                self.destinatinAddr = String(self.latitude) + "," + String(self.longitude)
                print("patientt")
                print(self.destinatinAddr )
                
                var urlString = "http://maps.google.com/maps?"
                urlString += "saddr=\(self.currentAddr)"
                urlString += "&daddr=\(self.destinatinAddr)"
                
                
                if let url = NSURL(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!){
                    
                    UIApplication.sharedApplication().openURL(url)
                }
            }
        })

    }
    
    
     //On click Patient Telephone automatically Phone call starts
    @IBAction func patientTelephonecall(sender: UIButton) {
        
        let number1 = sender.titleLabel?.text
        if let url = NSURL(string: "telprompt://0049\(number1!.stringByReplacingOccurrencesOfString(" ", withString: ""))") {
            UIApplication.sharedApplication().openURL(url)
        }

    }
    
     //On click Relative Telephone automatically Phone call starts
    @IBAction func relativeTelephonecall(sender: UIButton) {
        
        let number2 = sender.titleLabel?.text
        if let url2 = NSURL(string: "telprompt://0049\(number2!.stringByReplacingOccurrencesOfString(" ", withString: ""))") {
            UIApplication.sharedApplication().openURL(url2)
        }
    }

     //On click Doctor Telephone automatically Phone call starts
    @IBAction func doctorTelephonecall(sender: UIButton) {
        let number3 = sender.titleLabel?.text
        if let url3 = NSURL(string: "telprompt://0049\(number3!.stringByReplacingOccurrencesOfString(" ", withString: ""))") {
            UIApplication.sharedApplication().openURL(url3)
        }
    }
    
    @IBAction func backToPreviousView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
  }
