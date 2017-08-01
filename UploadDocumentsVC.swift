//
//  UploadDocumentsVC.swift
//  CTM App
//
//  Created by Marvin Kankiriho on 02/03/2017.
//  Copyright © 2017 HASHPi. All rights reserved.
//

import UIKit
import Firebase

class UploadDocumentsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
// MARK: -OUTLETS
    //Labels
    @IBOutlet var selectDocumentLabel: UILabel!
    
    //Segement
    @IBOutlet var segmentOutlet: UISegmentedControl!
    
    //Imageview
    @IBOutlet var docImageView: UIImageView!
    
    
    // Picture storage array 
    var defaultImage : UIImage = #imageLiteral(resourceName: "356_CTM-Logo")
    var pickedPassportImage : UIImage! = nil
    var pickedFrontImage : UIImage! = nil
    var pickedNICImage : UIImage! = nil
    
    
// DATABASE AND STORAGE REFERENCES
    var storageReference : FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load default pic
        docImageView.image = #imageLiteral(resourceName: "356_CTM-Logo")

    
    } // end if VIEW LOAD
    
    
    
    
    // MOCK save button
    @IBAction func mockSave(_ sender: Any) {
    
    }
    
    
    
// MARK: -ACTIONS
    // save button
    @IBAction func saveDOCButtonAction(_ sender: Any) {
        // perform segue to login page
        performSegue(withIdentifier: "DOC2ALLEVTSegue", sender: self)
        
    } //SAVE BUTTON end
    
    // Photo library button
    @IBAction func libraryImportBTN(_ sender: Any) {
        if segmentOutlet.selectedSegmentIndex == 0 {
            
            // Open photo library
            // UI Image deligate
            let passportPhoto = UIImagePickerController()
            passportPhoto.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            passportPhoto.delegate = self
            passportPhoto.allowsEditing = false
            
            self.present(passportPhoto, animated: true) { }

            
        } else if segmentOutlet.selectedSegmentIndex == 1 {
            // check if image already exists and set it as title
            
            
            // Open photo library
            // UI Image deligate
            let phtoPage = UIImagePickerController()
            phtoPage.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            phtoPage.delegate = self
            phtoPage.allowsEditing = false
            
            self.present(phtoPage, animated: true) { }
            
            
            
            //print
            print("Photo Page")
            
        } else if segmentOutlet.selectedSegmentIndex == 2 {
            // check if image already exists and set it as title
            
            
            
            // Open photo library
            // UI Image deligate
            let nationalInsurance = UIImagePickerController()
            nationalInsurance.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            nationalInsurance.delegate = self
            nationalInsurance.allowsEditing = false
            
            self.present(nationalInsurance, animated: true) { }
            
            // print
            print("NI Card")
        }
    }
    
    // Camera action
    @IBAction func cameraImportBTN(_ sender: Any) {
        
    }
    
    
    // SEGEMENTED CONTROL ACTION
    @IBAction func segmentedActionCotroll(_ sender: Any) {
        if segmentOutlet.selectedSegmentIndex == 0 {
        // check if image already exists and set it as title
            if pickedPassportImage != nil {
                docImageView.image = pickedPassportImage
            } else {
                
                docImageView.image = #imageLiteral(resourceName: "356_CTM-Logo")
            }
            
            // print
            print("Passport Photo")
            
        } else if segmentOutlet.selectedSegmentIndex == 1 {
        // check if image already exists and set it as title
            if pickedFrontImage != nil {
                docImageView.image = pickedFrontImage
            } else {
                
                docImageView.image = #imageLiteral(resourceName: "356_CTM-Logo")
            }
            
            //print
            print("Photo Page")
            
        } else if segmentOutlet.selectedSegmentIndex == 2 {
        // check if image already exists and set it as title
            if pickedNICImage != nil {
                docImageView.image = pickedNICImage
            } else {
                
                docImageView.image = #imageLiteral(resourceName: "356_CTM-Logo")
            }
            
            // print
            print("NI Card")
        }
    }
    
    
// MARK: -FUNCTIONS
    
    // IMAGE PICKER FUNCTION
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagePickerPNG = info[UIImagePickerControllerOriginalImage] as? UIImage, let imageData = UIImageJPEGRepresentation(imagePickerPNG,0.8)
        {
            
            if segmentOutlet.selectedSegmentIndex == 0 {
                // display image
                pickedPassportImage = imagePickerPNG
                docImageView.image = pickedPassportImage
                
                // Call for image to be uploaded
                uploadPassportPhoto(data: imageData)
                
                
            } else if segmentOutlet.selectedSegmentIndex == 1 {
                // display image on image view
                pickedFrontImage = imagePickerPNG
                docImageView.image = pickedFrontImage
                
                // Call for image to be uploaded
                uploadPassportFrontPage(data: imageData)
                
            } else if segmentOutlet.selectedSegmentIndex == 2 {
                // display image on image view
                pickedNICImage = imagePickerPNG
                docImageView.image = pickedNICImage
                
                // Call for image to be uploaded
                uploadNationalInsuranceCard(data: imageData)
                
            } // NESTED if end
            
    // dissmis the image picker
    self.dismiss(animated: true, completion: nil)
            
        }  // end of IF LET
        
    } // end imagePickertController

// MARK; - IUPLOAD FUNCTIONS
    // Upload passport photo
    func uploadPassportPhoto(data : Data) {
    // TO DO: Upload task
        // Storage reference
        self.storageReference = FIRStorage.storage().reference()
        
        let passportImageStorageRef = storageReference.child("RTW Documents").child("Passport Image")
        
        let passportImageMetadata = FIRStorageMetadata()
        passportImageMetadata.contentType = "image/jpeg"
        
        // storage task
        passportImageStorageRef.put(data, metadata: passportImageMetadata) { (metadata, error) in
            if (error != nil) {
                
                print("ERROR!!")
                
            } else {
                
            print("UPLOAD SUCCESFULL")
                
            }// end of error completion
        } // end upload task
        
        // Update a progress bar-------------------
        
    } // end passport photo upload
    
    
    // Upload front page photo
    func uploadPassportFrontPage(data : Data) {
        // TO DO: Upload task
        // Storage reference
        self.storageReference = FIRStorage.storage().reference()
        
        let passportFrontPageStorageRef = storageReference.child("RTW Documents").child("Passport Front Page")
        
        let passportFrontImageMetadata = FIRStorageMetadata()
        passportFrontImageMetadata.contentType = "image/jpeg"
        
        // storage task
        passportFrontPageStorageRef.put(data, metadata: passportFrontImageMetadata) { (metadata, error) in
            if (error != nil) {
                
                print("front ERROR!!")
                
            } else {
                
                print("UPLOAD front SUCCESFULL")
                
            }// end of error completion
        }// end upload task
        
        // Update a progress bar-------------------
        
    } // end front page upload
    
    
    // Upload NI card
    func uploadNationalInsuranceCard(data : Data) {
// TO DO: Upload task
        // Storage reference
        self.storageReference = FIRStorage.storage().reference()
        
          let nationalInsuranceStorageRef = storageReference.child("RTW Documents").child("National Insurance Card")
        
        let niImageMetadata = FIRStorageMetadata()
        niImageMetadata.contentType = "image/jpeg"
        
        // storage task
        nationalInsuranceStorageRef.put(data, metadata: niImageMetadata) { (metadata, error) in
            if (error != nil) {
                
                print("NI ERROR!!")
                
            } else {
                
                print("UPLOAD NI SUCCESFULL")
                
            } // end of error completion
        } // end upload task
        
        // Update a progress bar-------------------  
        
    } // end NI upload
    
    
    
    
    
    
    
    
    
} // end VC
