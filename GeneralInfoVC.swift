//
//  GeneralInfoVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 26/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GeneralInfoVC: UIViewController {
// MARK: - OUTLETS
    
    // Textfields
    @IBOutlet var gender: UITextField!
    @IBOutlet var ethinicOrigin: UITextField!
    @IBOutlet var nationality: UITextField!
    
        // emergency
        @IBOutlet var emContactName: UITextField!
        @IBOutlet var emRelationship: UITextField!
        @IBOutlet var emContactNo: UITextField!
    

    // Button outlets
    @IBOutlet var savebtnOUT: UIButton!
    
    // Boolean Switches
    
    // Name Labels
    @IBOutlet var fNLabel: UILabel!
    @IBOutlet var LnLabel: UILabel!
    
    
    // segue data transfer variables
    var fstNameVar = String()
    var lstNameVar = String()
    
// DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // named variables
        fNLabel.text = fstNameVar
        LnLabel.text = lstNameVar

        
    } // end of view load

// MARK: - ACTIONS
    //save / continue action
    @IBAction func saveContinueGenBtn(_ sender: Any) {
        // named variables
        let fstNameGenInfoVL = fNLabel.text!
        let lstNameGenInfoVL = LnLabel.text!
        
        // vaariable names
        let sex = gender.text
        let ethinicity = ethinicOrigin.text
        let nation = nationality.text
        let emergName = emContactName.text
        let emergRelation = emRelationship.text
        let emergNo = emContactNo.text
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if ethinicity!  == "" || nation!  == "" || emergName!  == "" || emergNo!  == "" {
            
            // hide the save / continue button
            savebtnOUT.tintColor = UIColor.red
            
        } else {
            savebtnOUT.tintColor = UIColor.green
            
            // Store entered data
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameVar)") // insert sent data
            
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Ethinicity").child("Gender").setValue(sex)
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Ethinicity").child("Ethinic Origin").setValue(ethinicity)
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Ethinicity").child("Nationality").setValue(nation)
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Emergency Details").child("Emergency Contact").setValue(emergName)
            self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Emergency Details").child("Emergency Contact Relation").setValue(emergRelation)
             self.dbReference.child("Martials").child("\(fstNameGenInfoVL) \(lstNameGenInfoVL)").child("Emergency Details").child("Emergency Number").setValue(emergNo)
            
        } // end if else
        
        // perform segue to go to thr next page
        performSegue(withIdentifier: "mDet2uAddSegue", sender: self)
        
        
    } // end save ACTION
 
// MARK: - FULL NAME TRANSFER OVERIDE FUNC    
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let addressInfo : UserAddressVC = segue.destination as! UserAddressVC
        
        addressInfo.fstNameVarADD = fstNameVar
        addressInfo.lstNameVarADD = lstNameVar
        
        
    } // end of prepare segue
    
    
} // end VC

