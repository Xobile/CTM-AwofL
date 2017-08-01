//
//  SelectInterestedEventsTVC.swift
//  
//
//  Created by Marvin Kankiriho on 15/03/2017.
//
//

import UIKit
import Firebase

class SelectInterestedEventsTVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
// MARK: - OUTLETS
    
    // Table view outlets
    @IBOutlet var eventSelectTableView: UITableView!
    
    // Table view data source
    var allEventsStringArray = [String]()
    
    // Array to store my events
    

    // DATAVASE REFERENCE
    var dbReference : FIRDatabaseReference!
    var dbHandle : FIRDatabaseHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the database reference
        dbReference = FIRDatabase.database().reference()
        
        // Retrieve data and listen for changes on the main events
        dbHandle = dbReference?.child("All Events").observe(.childAdded, with: { (snapshot) in
            // Convert value to string
            let oneEvent = snapshot.key
            
            // Append data to oput event array
            self.allEventsStringArray.append(oneEvent)
            
            // reload table view
            self.eventSelectTableView.reloadData()
            
        }) // end dhHandle OBSERVE

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

// MARK: - TABLE VIEW FUNCTIONS
    
    // Number of sections
    public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // Number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return allEventsStringArray.count
    }
    
    // Row at index path
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        // obtain reusable cell
        let cell = UITableViewCell()
        // Configure the cell...
        cell.textLabel?.text = allEventsStringArray[indexPath.row]
        
        return cell

    } // end cell for what
    
    // DID SELECT FUNCTIONS
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the accesibility
        let selectedSURow : UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedSURow.accessoryType = UITableViewCellAccessoryType.checkmark
        
        if selectedSURow.accessoryType == UITableViewCellAccessoryType.none {
            // tick the event selection
            selectedSURow.accessoryType = UITableViewCellAccessoryType.checkmark
            
            // Append selected row to array
            let eventSelection = selectedSURow.textLabel?.text
            // Database reference
            self.dbReference = FIRDatabase.database().reference()
            
            // Store entered data corresponding to the current user
            self.dbReference.child("Interest Events").childByAutoId().setValue(eventSelection)

        } else {
            // Un-tick the select
            selectedSURow.accessoryType = UITableViewCellAccessoryType.none
            // remove from data from database
            
        } // end if else
        
    } // end did select


}
