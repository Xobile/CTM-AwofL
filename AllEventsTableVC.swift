//
//  AllEventsTableVC.swift
//  CTM App
//
//  Created by Marvin Kankiriho on 07/03/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase

class AllEventsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
// MARK: - OUTLETS
    // Table view outlets
    @IBOutlet var allEventsTableView: UITableView!
    
    // Table view data source
    var allEventsStringArray = [String]()
    var eventDatesStringArray = [String]()
    var eventPostcodesStringArray = [String]()
    
    // Button outlet
    @IBOutlet var saveButtonOUT: UIButton!
    
    // Name labels
    @IBOutlet var firstNameEVTLabel: UILabel!
    @IBOutlet var lastNameEVTLabel: UILabel!
    
    // Full name variables
    var firstNameEVTVL = String()
    var lastNameEVTVL = String()
    
    // INTERESTED EVENT ARRAY
    var interestedEvent = [String]()
    
    // DATABASE REFERENCE
    var dbReference : FIRDatabaseReference!
    var dbHandle : FIRDatabaseHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Self reference to delegate and datasource
        allEventsTableView.delegate = self
        allEventsTableView.dataSource = self
        
        // Set the database reference
        dbReference = FIRDatabase.database().reference()
        
        // Retrieve data and listen for changes on the main events
        dbHandle = dbReference?.child("All Events").observe(.childAdded, with: { (snapshot) in
            // Convert value to string
            let oneEvent = snapshot.key

                // Append data to oput event array
                self.allEventsStringArray.append(oneEvent)
            
                // reload table view 
                self.allEventsTableView.reloadData()

        }) // end dhHandle OBSERVE
     
    } // end view load
    
// MARK: - SAVE BUTTON ACTION
    @IBAction func saveButtonEVTACTION(_ sender: Any) {
   // save selected events to a new database for the specific user

        // perform segue to login page
        performSegue(withIdentifier: "AllEvents2SplashSegue", sender: self)
    
    }
    
// MARK: - TABLE VIEW FUNCTIONS
    // Number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return allEventsStringArray.count
    }
    
    // Row at index path
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let myCell = tableView.dequeueReusableCell( withIdentifier: "Cell", for: indexPath)
        
        // set event name
        myCell.textLabel?.text = allEventsStringArray[indexPath.row]
        
        // Return statement
        return myCell
        
    } // end cell for what

    // Row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the accesibility 
        let selectedSURow : UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedSURow.accessoryType = UITableViewCellAccessoryType.checkmark
        
        if selectedSURow.accessoryType == UITableViewCellAccessoryType.checkmark{
         // Append selected row to array
            // interestedEvent.append((selectedRow.textLabel?.text)!)
            let eventSelection = selectedSURow.textLabel?.text
            // Get user email
            //let loggedMartial = FIRAuth.auth()?.currentUser
            
            // Database reference
            self.dbReference = FIRDatabase.database().reference()
            
            // Store entered data corresponding to the current user
            self.dbReference.child("Interest Events").childByAutoId().setValue(eventSelection)
            
         } // end if selected row 
        
        // else uncheckmark and delete from the interest table
        
    } // end row did select
    
} // end vc
