
//
//  PotentialEventsTVC.swift
//  CTM App
//
//  Created by Marvin Kankiriho on 15/03/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase

class PotentialEventsTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
// MARK: - OUTLETS
    // Tableview outlets
    @IBOutlet var interestedEventsTable: UITableView!
    
    // Data variables
    var interestedEventArray = [String]()
    
    // DATABASE REF / HANDLE
    var dbReference : FIRDatabaseReference!
    var dbHandle : FIRDatabaseHandle!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the database reference
        dbReference = FIRDatabase.database().reference()
        // Retrieve data and listen for changes on the main events
        dbHandle = dbReference?.child("Interest Events").observe(.childAdded, with: { (snapshot) in
            // Convert value to string
            let oneEvent = snapshot.value as! String
            
            // Append data to oput event array
            self.interestedEventArray.append(oneEvent)
            
            // reload table view
            self.interestedEventsTable.reloadData()
            
        }) // end dhHandle OBSERVE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view functions
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interestedEventArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // obtain re usable cell
        
        let cell = UITableViewCell()
        // Configure the cell...
        cell.textLabel?.text = interestedEventArray[indexPath.row]
        
        return cell
    }
    
    // DID SELECT FUNCTIONS
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.cellForRow(at: indexPath)
        
        if selectedRow?.accessoryType == UITableViewCellAccessoryType.none {
            // show detail button
            selectedRow?.accessoryType = UITableViewCellAccessoryType.detailButton
            
        } else {
           // remove detail button
            selectedRow?.accessoryType = UITableViewCellAccessoryType.none
      
        } // end if else
        
    } // end did select
    
    // DELETE EVENT SELECTION FROM DATABASE
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let deletedRow : UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            // delete from array
            interestedEventArray.remove(at: indexPath.row)
            
            // delete data from database
            
            // show the delete animation slide
            interestedEventsTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            deletedRow.accessoryType = UITableViewCellAccessoryType.none
            
            
        }
    }

}
