//
//  CharacterRefVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 27/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CharacterRefVC: UIViewController {
// MARK: - OUTLETS
    // Textfields
    @IBOutlet var charRefNameTXT: UITextField!
    @IBOutlet var charRefRelationTXT: UITextField!
    @IBOutlet var charRefCompanyTXT: UITextField!
    @IBOutlet var charRefEmailTXT: UITextField!
    @IBOutlet var charRefPhoneNumberTXT: UITextField!
    
    @IBOutlet var charRefAddressTXT: UITextField!
    @IBOutlet var charRefAreaTXT: UITextField!
    @IBOutlet var charRefTownTXT: UITextField!
    @IBOutlet var charRefCountyTXT: UITextField!
    @IBOutlet var charRefCountryTXT: UITextField!
    @IBOutlet var charRefPostcodeTXT: UITextField!
    
    
    // Labels
    @IBOutlet var firstNameCREFLabel: UILabel!


    // Button Outlets
    @IBOutlet var cREFsaveBtnOUT: UIButton!
    @IBOutlet var lastNameCREFLabel: UILabel!

    
    // Full name variables
    var firstNameCRefVL = String()
    var lastNameCRefVL = String()
    
    // DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set full name labels to parsed data
        firstNameCREFLabel.text = firstNameCRefVL
        lastNameCREFLabel.text = lastNameCRefVL
        
        
    } // end of VIEW LOAD

// MARK: - ACTIONS
    // Save / Continue ACTION
    @IBAction func cREFsaveButtonACTION(_ sender: Any) {
 
        // name variables
        let cRefFirst = firstNameCREFLabel.text!
        let cRefLast = lastNameCREFLabel.text!
        
        // texstfield text variables
        let charRefName = charRefNameTXT.text
        let charRefRelation = charRefRelationTXT.text
        let charRefCompany = charRefCompanyTXT.text
        let charRefEmail = charRefEmailTXT.text
        let charRefPhoneNumber = charRefPhoneNumberTXT.text
        
        let charRefAddress = charRefAddressTXT.text
        let charRefArea = charRefAreaTXT.text
        let charRefTown = charRefTownTXT.text
        let charRefCounty = charRefCountyTXT.text
        let charRefCountry = charRefCountryTXT.text
        let charRefPostcode = charRefPostcodeTXT.text
        
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if charRefName!  == "" || charRefRelation!  == "" || charRefPhoneNumber!  == "" || charRefAddress!  == "" {
            
            // hide the save / continue button
            cREFsaveBtnOUT.tintColor = UIColor.red
            
        } else {
            cREFsaveBtnOUT.tintColor = UIColor.green
            
            // Store entered data
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Details").child("cRef Name").setValue(charRefName)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Details").child("cRef Relationship").setValue(charRefRelation)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Details").child("cRef Company Name").setValue(charRefCompany)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Details").child("cRef Email").setValue(charRefEmail)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Details").child("Reference Phone Number").setValue(charRefPhoneNumber)
            
            // address data
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef Number and Street").setValue(charRefAddress)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef Area Region").setValue(charRefArea)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef Town").setValue(charRefTown)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef County").setValue(charRefCounty)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef Country").setValue(charRefCountry)
            self.dbReference.child("Martials").child("\(cRefFirst) \(cRefLast)").child("Character Reference").child("Character Address").child("cRef Postcode").setValue(charRefPostcode)
            
        } // end if else
        
        // perform segue to go to the next page
        performSegue(withIdentifier: "cREF2RTWSegue", sender: self)
    
    }
    
// MARK: - FULL NAME TRANSFER OVERIDE FUNC
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let rtwInfo : RightToWorkVC = segue.destination as! RightToWorkVC
        
        rtwInfo.firstNameRTWVL = firstNameCRefVL
        rtwInfo.lastNameRTWVL = lastNameCRefVL
        
        
    } // end of prepare segue

} // end of VC
