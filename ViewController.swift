//
//  ViewController.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 17/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
// MARK: - OUTLETS
    // Segement controll
    @IBOutlet var logRegSegment: UISegmentedControl!
    
    // button outlets
    @IBOutlet var loginButtonOut: UIButton!
    
    
    // text fields
    @IBOutlet var firstLastName: UITextField! // name
    @IBOutlet var userEmail: UITextField! // email
    @IBOutlet var userPassword: UITextField! // password
    
    // labels
    @IBOutlet var nameLbel: UILabel! // username
    @IBOutlet var passLabel: UILabel! // email label
    
    
    // Database reference
    var dbReference : FIRDatabaseReference!
   
// MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set default segement
        logRegSegment.selectedSegmentIndex = 0
        // If user is logged in .. show user details
        let currentMartial = FIRAuth.auth()?.currentUser
        
        if currentMartial != nil {
            
            performSegue(withIdentifier: "Log2ProfSegue", sender: self)
            
        }
        
    } // end view did load

// MARK: -ACTIONS
    // SEGEMENTED CONTROLL ACTION
    @IBAction func logRegSegACTION(_ sender: Any) {
        if logRegSegment.selectedSegmentIndex == 0 {
            
            firstLastName.alpha = 1 // hide the full textfield
            loginButtonOut.titleLabel?.text = "Register" // set button tittle
            
        } else if logRegSegment.selectedSegmentIndex == 1 {
            
            firstLastName.alpha = 0 // show the full name
            loginButtonOut.titleLabel?.text = "Login" // set button tittle
            
            
        } // end if seg == #
    
    } // end segemented controll action
    
    
    // LOGIN button action
    @IBAction func loginBtn(_ sender: Any) {
        
        if loginButtonOut.titleLabel?.text == "Login" {
            
            // check if all fields are filled in
            if self.userPassword.text == "" || self.userEmail.text == ""  {
                // show an alert
                let alertController = UIAlertController(title: "Ooops", message: "Please fill in all details", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                present(alertController,animated: true, completion: nil)
                
            } else {
                
                // sign in with email
                FIRAuth.auth()?.signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!, completion: {(user, Error) in
                    // when there is no error hide all fields
                    if Error ==  nil {
                        
                        // GO TO PROFILE ProfileViewController
                        self.performSegue(withIdentifier: "Log2ProfSegue", sender: self)
                        
                    } else {
                        
                        // show an FIREBASE ERROR alert
                        let alertController = UIAlertController(title: "Ooops", message: Error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController,animated: true, completion: nil)
                        
                    } // end ekse
                    
                }) // end FIR.signIN
                
            } // end of check else
            
        } else if loginButtonOut.titleLabel?.text == "Register" {
            
            // check if all fields are filled in
            if self.firstLastName.text == "" || self.userEmail.text == "" || self.userPassword.text == ""  {
                // show an alert
                let alertController = UIAlertController(title: "Ooops", message: "Please fill in all details", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                present(alertController,animated: true, completion: nil)
                
            } else {
                
                //Create user and go to the next VC for more details
                FIRAuth.auth()?.createUser(withEmail: self.userEmail.text!, password: self.userPassword.text!, completion: {(user, Error) in
                    
                    // when there is no error hide all fields
                    if Error ==  nil {
                        
                        // Go to the profile VC with more user details
                        self.performSegue(withIdentifier: "Log2DetsSegue", sender: self)
                        
                    } else {
                        
                        // show an FIREBASE ERROR alert
                        let alertController = UIAlertController(title: "Ooops", message: Error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController,animated: true, completion: nil)
                        
                    } // end ekse
                    
                }) // end fire auth
                
            } //  end error else
            
        }// end if title label

    } // end login action

} // end VC
