//
//  SplashScreenVCViewController.swift
//  CTM App
//
//  Created by Marvin Kankiriho on 08/03/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashScreenVCViewController: UIViewController {

    
// MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        

    } // end view did laod
    
// MARK: - VIEW DID APPEAR
    // Present login page
    override func viewDidAppear(_ animated: Bool) {
        // set current user variable
        let currentMartial = FIRAuth.auth()?.currentUser
        
        // If user is logged in .. go to profile
        if currentMartial == nil {
            
            //show Login VC
            performSegue(withIdentifier: "Splash2LoginSegue", sender: self)
            
        } else {
            //show profile VC
            performSegue(withIdentifier: "Splash2ProfileSegue", sender: self)

        }
    }


}
