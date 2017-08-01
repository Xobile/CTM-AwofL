//
//  UserAddressVC.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 26/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class UserAddressVC: UIViewController {
// MARK: - OUTLETS
    //Textfields
    @IBOutlet var streetNumber: UITextField!
    @IBOutlet var areaRegion: UITextField!
    @IBOutlet var townCity: UITextField!
    @IBOutlet var countyRegion: UITextField!
    @IBOutlet var countryName: UITextField!
    @IBOutlet var postCode: UITextField!
    
    
    //Button outets
    @IBOutlet var saveContinueAddressBtn: UIButton!

    
    // segue data transfer variables
    var fstNameVarADD = String ()
    var lstNameVarADD = String ()

    // Labels
    @IBOutlet var firstNameADDLabel: UILabel!
    @IBOutlet var lastNameADDLabel: UILabel!

    
    
// DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        // Assign variables on view load
        firstNameADDLabel.text = fstNameVarADD
        lastNameADDLabel.text = lstNameVarADD
        
        
    } // end View LOAD
    
// MARK: - ACTIONS

    @IBAction func saveButtonADD(_ sender: Any) {
        
        // named variables
        let fstNameADDInfoVL = firstNameADDLabel.text!
        let lstNameADDInfoVL = lastNameADDLabel.text!
        
        // vaariable names
        let street = streetNumber.text
        let area = areaRegion.text
        let town = townCity.text
        let county = countyRegion.text
        let country = countryName.text
        let post = postCode.text
        
        // Database reference
        self.dbReference = FIRDatabase.database().reference()
        // if all fields are field in
        if street!  == "" || town!  == "" || county!  == "" || post!  == "" {
            
            // hide the save / continue button
            saveContinueAddressBtn.tintColor = UIColor.red
            
        } else {
            saveContinueAddressBtn.tintColor = UIColor.green
            
            // Store entered data
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)") // insert sent data
            
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("Number and Street").setValue(street)
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("Area Region").setValue(area)
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("Town").setValue(town)
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("County").setValue(county)
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("Country").setValue(country)
            self.dbReference.child("Martials").child("\(fstNameADDInfoVL) \(lstNameADDInfoVL)").child("Home Address").child("Postcode").setValue(post)
            
        } // end if else
        
        // perform segue to go to thr next page
        performSegue(withIdentifier: "uAdd2eREFSegue", sender: self)
        
    } // end SAVE ACTION
    
// MARK: - FULL NAME TRANSFER OVERIDE FUNC
    // send info to the next segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Go to profile page
        
        let eRefInfo : EmployerRefVC = segue.destination as! EmployerRefVC
        
        eRefInfo.firstNameErefVL = fstNameVarADD
        eRefInfo.lastNameErefVL = lstNameVarADD
        
        
    } // end of prepare segue
    

} // end VC
