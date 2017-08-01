//
//  BankDetailsVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 27/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BankDetailsVC: UIViewController {
// MARK: - OUTLETS
    // Textfields
    @IBOutlet var accountNameTXT: UITextField!
    @IBOutlet var accountNumberTXT: UITextField!
    @IBOutlet var sortCodeTXT: UITextField!
    @IBOutlet var nationalInsuranceTXT: UITextField!
    
    // Labels
    @IBOutlet var firstNameBankDetLabel: UILabel!
    @IBOutlet var lastNameBankDetLabel: UILabel!
    
    // BTN outlet
    @IBOutlet var bDETsaveBtnOUT: UIButton!
    
    
    // Full name variables
    var firstNamebDETVL = String()
    var lastNamebDETVL = String()
    
    // DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set full name label texts
        firstNameBankDetLabel.text = firstNamebDETVL
        lastNameBankDetLabel.text = lastNamebDETVL
        
        
    }// end VIEW LOAD
    
// MARK: - ACTIONS
    @IBAction func saveButtonBankDet(_ sender: Any) {
        // name variables
        let bDETFirst = firstNameBankDetLabel.text!
        let bDETLast = lastNameBankDetLabel.text!
        
        // texstfield text variables
        let accountName = accountNameTXT.text
        let accountNumber = accountNumberTXT.text
        let sortCode = sortCodeTXT.text
        let nationalInsurance = nationalInsuranceTXT.text
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if accountName!  == "" || accountNumber!  == "" || sortCode!  == "" || nationalInsurance!  == "" {
            
            // hide the save / continue button
            bDETsaveBtnOUT.tintColor = UIColor.red
            
        } else {
            bDETsaveBtnOUT.tintColor = UIColor.green
            
            // Store entered data
            self.dbReference.child("Martials").child("\(bDETFirst) \(bDETLast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(bDETFirst) \(bDETLast)").child("Bank Details").child("Account Name").setValue(accountName)
            self.dbReference.child("Martials").child("\(bDETFirst) \(bDETLast)").child("Bank Details").child("Account Number").setValue(accountNumber)
            self.dbReference.child("Martials").child("\(bDETFirst) \(bDETLast)").child("Bank Details").child("Sort Code").setValue(sortCode)
            self.dbReference.child("Martials").child("\(bDETFirst) \(bDETLast)").child("Bank Details").child("National Insurance").setValue(nationalInsurance)
        
    }
        // perform segue to go to thr next page
        performSegue(withIdentifier: "bDET2DOCSegue", sender: self)
        
    }// end SAVE BUTTON ACTION

    
// Override functions
    
} // end of VC
