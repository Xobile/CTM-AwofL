//
//  EmployerRefVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 27/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EmployerRefVC: UIViewController {
// MARK: - OUTLETS
    // Textfields
    @IBOutlet var jobTitleTXT: UITextField!
    @IBOutlet var jobStartDateTXT: UITextField!
    @IBOutlet var jobEndDateTXT: UITextField!
    @IBOutlet var companyNameTXT: UITextField!
    @IBOutlet var refereeNameTXT: UITextField!
    @IBOutlet var refPhoneNumberTXT: UITextField!
    
    @IBOutlet var preEmpAddressTXT: UITextField!
    @IBOutlet var preEmpAreaTXT: UITextField!
    @IBOutlet var preEmpTownTXT: UITextField!
    @IBOutlet var preEmpCountyTXT: UITextField!
    @IBOutlet var preEmpCountryTXT: UITextField!
    @IBOutlet var preEmpPostcodeTXT: UITextField!
    
    
    // LAbels
    @IBOutlet var firstNameEREFLabel: UILabel!
    @IBOutlet var lastNameEREFLabel: UILabel!
    
    // Button outlets
    @IBOutlet var saveEREFBtnOUT: UIButton!
    
    
    // Full name variables
    var firstNameErefVL = String()
    var lastNameErefVL = String()
    
    // DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    
    // MARK: -VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set ful name to labels
        firstNameEREFLabel.text = firstNameErefVL
        lastNameEREFLabel.text = lastNameErefVL
        
    } // end View LOad
    
// MARK: - ACTIONS
    // Save / Continue ACTION
    @IBAction func saveEREFButton(_ sender: Any) {
        // name variables
        let eRefFirst = firstNameEREFLabel.text!
        let eRefLast = lastNameEREFLabel.text!
        
        // texstfield text variables
        let jobTitle = jobTitleTXT.text
        let jobStartDate = jobStartDateTXT.text
        let jobEndDate = jobEndDateTXT.text
        let companyName = companyNameTXT.text
        let refereeName = refereeNameTXT.text
        let refPhoneNumber = refPhoneNumberTXT.text
        
        let preEmpAddress = preEmpAddressTXT.text
        let preEmpArea = preEmpAreaTXT.text
        let preEmpTown = preEmpTownTXT.text
        let preEmpCounty = preEmpCountyTXT.text
        let preEmpCountry = preEmpCountryTXT.text
        let preEmpPostcode = preEmpPostcodeTXT.text
        
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if jobTitle!  == "" || refereeName!  == "" || refPhoneNumber!  == "" || preEmpAddress!  == "" {
            
            // hide the save / continue button
            saveEREFBtnOUT.tintColor = UIColor.red
            
        } else {
            saveEREFBtnOUT.tintColor = UIColor.green
            
            // Store entered data
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("eRef Job Title").setValue(jobTitle)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("Start Date").setValue(jobStartDate)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("End Date").setValue(jobEndDate)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("eRef Company Name").setValue(companyName)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("eRef Name").setValue(refereeName)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Details").child("eRef Phone Number").setValue(refPhoneNumber)
            
            // address data
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef Number and Street").setValue(preEmpAddress)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef Area Region").setValue(preEmpArea)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef Town").setValue(preEmpTown)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef County").setValue(preEmpCounty)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef Country").setValue(preEmpCountry)
            self.dbReference.child("Martials").child("\(eRefFirst) \(eRefLast)").child("Employement Reference").child("Job Address").child("eRef Postcode").setValue(preEmpPostcode)
            
        } // end if else
        
        // perform segue to go to thr next page
        performSegue(withIdentifier: "eREF2cREFSegue", sender: self)
        
    } // end of SAVE BUTTON
    
// MARK: - FULL NAME TRANSFER OVERIDE FUNC
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let charRefInfo : CharacterRefVC = segue.destination as! CharacterRefVC
        
        charRefInfo.firstNameCRefVL = firstNameErefVL
        charRefInfo.lastNameCRefVL = lastNameErefVL
        
        
    } // end of prepare segue


} // end of VC
