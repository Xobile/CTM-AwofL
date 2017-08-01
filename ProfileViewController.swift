//
//  ProfileViewController.swift
//  LOGin
//
//  Created by Marvin Kankiriho on 21/02/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {
    
// MARK: - OUTLETS
    
    // labels
    @IBOutlet var currentFLName: UILabel! //username
    
    @IBOutlet var currentEmail: UILabel! // email
    
    // prepare segue variables
    var currentFLNameVar : String = ""
    var currentEmailVar : String  = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the username and emails
        
        
        // If user is logged in .. show user details
         let currentMartial = FIRAuth.auth()?.currentUser
        
        if currentMartial != nil {
            
            currentEmail.text = currentMartial?.email
            
        }
        

        
    } // end view did load

// MARK: ACTIONS
    // Logout button action
    @IBAction func logoutButtonAction(_ sender: Any) {
        // log user out
        try! FIRAuth.auth()?.signOut()
        
        // Return to the login page
        
        
    } // end Logout btn
    
    
} // end VC
