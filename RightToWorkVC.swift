//
//  RightToWorkVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 27/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RightToWorkVC: UIViewController, UIPickerViewDelegate {
// MARK: - OUTLETS
    // Textfields
    
    
    // Labels
    @IBOutlet var rtwFirstLabel: UILabel!
    @IBOutlet var rtwLastLabel: UILabel!
  
    
    
    // Button Outlets


    
    
    // Full name variables
    var firstNameRTWVL = String()
    var lastNameRTWVL = String()
    
    // DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    
    // Picker variables
        var rtwPickerItems = ["UK Citizen","European National","Non European National"] // picker array
    
    // picket outlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set full name label texts
        rtwFirstLabel.text = firstNameRTWVL
        rtwLastLabel.text = lastNameRTWVL
        
        
        
    }// end VIEW LOAD]
    
// MARK: - SAVE BUTTON ACTIONS
    @IBAction func saveButtonRTW(_ sender: Any) {
        // perform segue to go to thr next page
        performSegue(withIdentifier: "RTW2bDETSegue", sender: self)
        
    } // end of SAVE BUTTON

    
// MARK: - MAJOR PICKER FUNCTIONS
    
    //Number of components i.e spinny wheels
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Number of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        // count items in the array
        return rtwPickerItems.count
    }
    
    // Tittle for the spinner
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return rtwPickerItems[row]
    }
    
    // When row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        // name variables
        let rtwfirst = self.rtwFirstLabel.text!
        let rtwlast = self.rtwLastLabel.text!
        
        // insert picker selection to variable
        let selectedpickerText = rtwPickerItems[row]
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        
        switch (selectedpickerText) {
        case "UK Citizen":
            // set the coresponding to value in database
            // Store entered data
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)").child("Right To Work").child("RTW").setValue("UK Citizen")
             break
        case "European National":
            // set the coresponding to value in database
            // Store entered data
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)").child("Right To Work").child("RTW").setValue("European National")
             break
        case "Non European National":
            // set the coresponding to value in database
            // Store entered data
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)") // insert sent data
            
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)").child("Right To Work").child("RTW").setValue("Non European National")
             break
        default:
            // default action
            // Store entered data
            self.dbReference.child("Martials").child("\(rtwfirst) \(rtwlast)").child("Right To Work").setValue("Not Available") // insert sent data
            
             break
            
        } // end of switch
        
    } // end of selected row func
    
// MARK: - FULL NAME TRANSFER OVERIDE FUNC
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let bankInfo : BankDetailsVC = segue.destination as! BankDetailsVC
        
        bankInfo.firstNamebDETVL = firstNameRTWVL
        bankInfo.lastNamebDETVL = lastNameRTWVL
        
        
    } // end of prepare segue
    
    
    
} // end of VC
