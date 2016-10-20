//
//  Patients.swift
//  KPSE1
//
//  Created by Spurti Benakatti on 05/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

class Patients {
    
    // MARK: Properties
    
    //Values of the Patient List Table. Information about Patient
    
    var wapon : UIImage             //Patient's State recognisation Image
    var patientName: String         //Patient Name
    var keynumber: String           //Patient House Key number
    var adress : String             //Patient House address
    var patientTel : String                //Patient Telephone Number
    var KlingelImage : UIImage!     //Image :  whether to Ring the Door Bell or not to Ring the Door Bell
    var date : String               // Date and Time of the Tasks
    var duration : String           //Time duration of task
    var time = String()
    var etage = String()
    var aufzug = String()
    var tur   = String()
    var relativeName = String()
    var relativeTel = String()
    var doctorName = String()
    var doctorTel = String()
    var LKDetail1 = String()
    var LKDetail2 = String()
    var info1 = String()
    var info2 = String()

    
    // MARK: Initialization of the patintList Table data values
    
    init?( wapon : UIImage ,patientName: String , keynumber : String , adress : String, patientTel: String, KlingelImage : UIImage!, date : String, duration : String , time : String , etage : String , aufzug : String , tur : String , relativeName : String , relativeTel : String , doctorName : String , doctorTel : String , LKDetail1 : String , LKDetail2 : String , info1 : String , info2 : String  ) {
        
        // Initialize stored properties.
        self.wapon = wapon
        self.patientName = patientName
        self.keynumber = keynumber
        self.adress = adress
        self.patientTel = patientTel
        self.date = date
        self.KlingelImage = KlingelImage
        self.duration = duration
        self.time = time
        self.etage = etage
        self.aufzug = aufzug
        self.tur = tur
        self.relativeName = relativeName
        self.relativeTel = relativeTel
        self.doctorName = doctorName
        self.doctorTel = doctorTel
        self.LKDetail1 = LKDetail1
        self.LKDetail2 = LKDetail2
        self.info1 = info1
        self.info2 =  info2
    }
    
    
}
