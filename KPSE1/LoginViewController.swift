//
//  LoginViewController.swift
//  KPSE1
//
//  Created by Spurti Benakatti on 01/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit
import MessageUI
import CoreData


class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    var delegate: AppDelegate!
    
    //MARK: Properties

    @IBOutlet weak var benutzerNameTextField: UITextField!
    
    @IBOutlet weak var passwortTextField: UITextField!
    
    let date = NSDate().toLocalTime()
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            benutzerNameTextField.delegate = self
            passwortTextField.delegate = self
        
            //TextField Bottom line

        let bottomLine = CALayer()
        
        bottomLine.frame = CGRectMake(0.0, 42 , 170, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        benutzerNameTextField.borderStyle = UITextBorderStyle.None
        benutzerNameTextField.layer.addSublayer(bottomLine)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRectMake(0.0, 30,170, 1.0)
        bottomLine2.backgroundColor = UIColor.blackColor().CGColor
        passwortTextField.borderStyle = UITextBorderStyle.None
        passwortTextField.layer.addSublayer(bottomLine2)

        
       // passwortTextField.borderStyle = UITextBorderStyle.None
       // passwortTextField.layer.addSublayer(bottomLine)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            if textField == self.benutzerNameTextField {
                self.passwortTextField.becomeFirstResponder()
                textField.resignFirstResponder()
            } else if textField == self.passwortTextField {
                 textField.resignFirstResponder()
            }
            return true
        }
    
        // Open and Hide Keyboard
    
    func animateTextField(textField: UITextField, up: Bool)
        {
            let movementDistance:CGFloat = -130
            let movementDuration: Double = 0.3
        
            var movement:CGFloat = 0
                if up
                    {
                        movement = movementDistance
                    }
                else
                    {
                        movement = -movementDistance
                    }
            UIView.beginAnimations("animateTextField", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration)
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
            UIView.commitAnimations()
        }
    
    
    func textFieldDidBeginEditing(textField: UITextField)
        {
            self.animateTextField(textField, up:true)
        }
    
    func textFieldDidEndEditing(textField: UITextField)
        {
            self.animateTextField(textField, up:false)
        }
    
   
    //MARK : Actions
    
    
    //Kontakt Automatik call
    
    @IBAction func kontaktCallTapGesture(sender: UITapGestureRecognizer) {
        
    
        let url : NSURL = NSURL (string: "tel://004942143028351")!
        [UIApplication.sharedApplication().openURL(url)]
        
        }
    
   
    //Login UserName and Password Authentication
    
    @IBAction func loginAuthentication(sender: UIButton) {
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        let user = NSEntityDescription.insertNewObjectForEntityForName("Login", inManagedObjectContext: moc)
        
        //Add new user
        user.setValue("KPSBremen", forKey: "name")
        user.setValue("bremen", forKey: "password")
        user.setValue(date, forKey: "time")
        

        
        let username = benutzerNameTextField.text
        let password = passwortTextField.text
        
        
        
        if (username == "KPSBremen" && password == "bremen"){
            //Add Info to the Entity
            
            do{
                try moc.save()
            }catch {
                print("There was an error saving data")
            }
            

            
        }
        else{ //If Login failed stay in same Login Page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.presentViewController(vc! as UIViewController, animated: true, completion: nil)
            
        }

        
    /*    //Retreive data
        
        do{
            
            let requset = NSFetchRequest(entityName: "Login")
            let results = try moc.executeFetchRequest(requset)
            requset.returnsObjectsAsFaults = false
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    
                   print("Login Details")
                    print(item)
                }
            }
        }catch{
            print("Error in Fetching date")
        }
        */
    }
    
        
    
       // TextField Border design
    
    private func addBottomLinetoTextFields(textField : UITextField){
    
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height)
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
         }
    
    
    }
