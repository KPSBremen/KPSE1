//
//  LogoutQRScanViewController.swift
//  KPSE1
//
//  Created by KPSBremen on 17/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
import CoreLocation
import CoreData

class LogoutQRScanViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate , CLLocationManagerDelegate {
  
    @IBOutlet weak var messagelabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    var adress : String!                    //Received Address of a Patient from previous view.
    var passName : String!                      //Received Name of a Patient from previous view.
    
    //QR Code Protocols
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let logoutTime = NSDate().toLocalTime()
    
    
    //Location tracking
    var locManager = CLLocationManager()
    var userLat = CLLocationDegrees()           //Pfleger current location Lattitude
    var userlong = CLLocationDegrees()          //Pfleger current location Longitude
    var latitude = CLLocationDegrees()          //Patient address lattitude
    var longitude = CLLocationDegrees()          //Patient address longitude
    var patientLat = String()
    var currentaddr = String()
    var patientLong = String()
    var currLat = String()
    var currLong = String()

    
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    

    
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
        
        currentaddr = String(userLat) + "," + String(userlong)

    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    do {
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    let input = try AVCaptureDeviceInput(device: captureDevice)
    
    // Initialize the captureSession object.
    captureSession = AVCaptureSession()
    // Set the input device on the capture session.
    captureSession?.addInput(input)
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession?.addOutput(captureMetadataOutput)
    
    // Set delegate and use the default dispatch queue to execute the call back
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    
    // Detect all the supported bar code
    captureMetadataOutput.metadataObjectTypes = supportedBarCodes
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    videoPreviewLayer?.frame = view.layer.bounds
    view.layer.addSublayer(videoPreviewLayer!)
    
    // Start video capture
    captureSession?.startRunning()
    
    // Move the message label to the top view
    view.bringSubviewToFront(messagelabel)
    view.bringSubviewToFront(backButton)
    
    // Initialize QR Code Frame to highlight the QR code
    qrCodeFrameView = UIView()
    
    if let qrCodeFrameView = qrCodeFrameView {
    qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
    qrCodeFrameView.layer.borderWidth = 2
    view.addSubview(qrCodeFrameView)
    view.bringSubviewToFront(qrCodeFrameView)
    }
    
    } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if metadataObjects == nil || metadataObjects.count == 0 {
        qrCodeFrameView?.frame = CGRectZero
        
        messagelabel.text = "NO QR code detected"
        return
    }
    
    // Get the metadata object.
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    
    // Here we use filter method to check if the type of metadataObj is supported
    // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
    // can be found in the array of supported bar codes.
    if supportedBarCodes.contains(metadataObj.type) {
        //        if metadataObj.type == AVMetadataObjectTypeQRCode {
        // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
        let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
        
        
        
        if metadataObj.stringValue != nil {
                messagelabel.text = metadataObj.stringValue
                self.captureSession?.stopRunning()
                self.performSegueWithIdentifier("donePatientLogout" , sender:self )
            
            let moc = DataController().managedObjectContext
            let user = NSEntityDescription.insertNewObjectForEntityForName("Patient", inManagedObjectContext: moc)
            
            user.setValue(logoutTime, forKey: "logouttime")
            user.setValue(currentaddr, forKey: "logoutlocation")
            user.setValue(passName, forKey: "patientname")
            do{
                try moc.save()
            }catch {
                print("There was an error saving data")
            }
            
            
            //Retreive data
            
            do{
                
                let requset = NSFetchRequest(entityName: "Patient")
                requset.returnsObjectsAsFaults = false
                let results = try moc.executeFetchRequest(requset)
                
                if results.count > 0 {
                    
                    for item in results as! [NSManagedObject] {
                        
                        print("** Patient Logout Details **")
                        print(item)
                    }
                }
            }catch{
                print("Error in Fetching date")
            }
            

            
            }
            
            else {
                self.captureSession?.stopRunning()
                self.performSegueWithIdentifier("backToPatientLogout", sender: self)
                
            }
        }
    }



//Segue to Patient login page

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "backToPatientLogout"
    {
        let controller = segue.destinationViewController as! PatientLogoutViewController
        
        controller.passName = passName
    }
    else if (segue.identifier == "donePatientLogout"){
        
        let controller =  segue.destinationViewController as! PatientenlistViewController
        
        controller.name = passName
        
    }
}

}


