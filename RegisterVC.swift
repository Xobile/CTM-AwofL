//
//  RegisterVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 26/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterVC: UIViewController {
// MARK: - OUTLETS
    
    // Textfields
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var dateOfBirth: UITextField!
    @IBOutlet var contactNumber: UITextField!
    
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var confirmPassword: UITextField!

    @IBOutlet var ctmIntro: UITextField!
    
    // BUTTON OUTLETS
    @IBOutlet var saveContOUT: UIButton!
    @IBOutlet var currentUserOUT: UIButton!
    
    
    // DATABASE REFERENCE 
    var dbReference : FIRDatabaseReference!

// MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

// MARK: - ACTIONS

    // Save / Continue BUTTON
    @IBAction func saveContinueButton(_ sender: Any) {
        // Named variables
        let fstName = firstName.text
        let lstName = lastName.text
        let dob = dateOfBirth.text
        let mobileNo = contactNumber.text
        
        let email = emailAddress.text
        let passW = passWord.text
        let passCW = confirmPassword.text
        
        let intro = ctmIntro.text
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if mobileNo  == "" || email  == "" || passW  == "" || passCW  == "" {
            
            // hide the save / continue button
            saveContOUT.tintColor = UIColor.red
            
        } else {
              saveContOUT.tintColor = UIColor.green

            // Store entered data
            self.dbReference.child("Martials").child("\(fstName!) \(lstName!)") // insert sent data
            
            self.dbReference.child("Martials").child("\(fstName!) \(lstName!)").child("General User Detail").child("Email").setValue(email)
            
            if passW == passCW {
                self.dbReference.child("Martials").child("\(fstName!) \(lstName!)").child("General User Detail").child("Password").setValue(passCW)
            } else {
                // show an alert
                let alertController = UIAlertController(title: "Ooops", message: "Password Miss Match !!!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                present(alertController,animated: true, completion: nil)
            }

            self.dbReference.child("Martials").child("\(fstName!) \(lstName!)").child("General User Detail").child("DOB").setValue(dob)
            self.dbReference.child("Martials").child("\(fstName!) \(lstName!)").child("General User Detail").child("Contact Number").setValue(mobileNo)
            
            
            self.dbReference.child("Martials").child("\(fstName!) \(lstName!)").child("General User Detail").child("CTM Intro").setValue(intro)
            
            
        } // end if statement
        
        // perform segue to go to thr next page
        performSegue(withIdentifier: "Reg2mDetSegue", sender: self)
        
        
    }  // end of save / continue
    
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let genInfo : GeneralInfoVC = segue.destination as! GeneralInfoVC
        
        genInfo.fstNameVar = self.firstName.text!
        genInfo.lstNameVar = self.lastName.text!
        
    } // end of prepare segue
    
    
    
    // Already have an acount button
    @IBAction func currentUserButton(_ sender: Any) {
        // Go back to login page
        //show proifile VC  Log2DetsSegue
        self.performSegue(withIdentifier: "Reg2LogSegue", sender: self)
        
    }
    
}
