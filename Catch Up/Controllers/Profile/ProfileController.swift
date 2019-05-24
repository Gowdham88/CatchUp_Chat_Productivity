//
//  ProfileController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/21/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import BottomPopup

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var supportView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var profileitems = ["Chat", "Invite Friends", "Theme", "Help", "Log Out"]
    var iconImages : [UIImage] = [UIImage(named: "message-square")!, UIImage(named: "users")!, UIImage(named: "sliders")!, UIImage(named: "help-circle")!, UIImage(named: "power")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        profileImage.layer.borderWidth = 1
//        profileImage.layer.masksToBounds = false
//        profileImage.layer.borderColor = UIColor.clear.cgColor
//        profileImage.layer.cornerRadius = profileImage.frame.height/2
//        profileImage.clipsToBounds = true

        profileImage.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: profileImage.frame.height/2)
        
        supportView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        

        let localFile = URL(string: "path/to/image")!
        
        let storage = Storage.storage()

        let storageRef = storage.reference()

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/rivers.jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = riversRef.putFile(from: localFile, metadata: metadata)
        
        
        uploadTask.observe(.success) { snapshot in
            
            print("Success")
            
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                
                print("FAILURE")
                
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func editPressed(_ sender: Any) {
        
        PresentPopup(Alertheader: "Edit Profile")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileitems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileTableViewCell
        
        cell.iconImage.image = iconImages[indexPath.row]

        cell.ProfileText.text = profileitems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }
    
   
    func PresentPopup(Alertheader: String) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? PopUpViewcontrollerViewController else { return }
        
        popupVC.popupDelegate = self as? BottomPopupDelegate
        popupVC.PageHeader = Alertheader
        present(popupVC, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0  :
            PresentPopup(Alertheader: "Chat")
        case 1  :
            PresentPopup(Alertheader: "Invite Friends")
        case 2  :
            PresentPopup(Alertheader: "Theme")
        case 3  :
            PresentPopup(Alertheader: "Help")
        case 4  :
            PresentPopup(Alertheader: "Log Out")
            
        default:
            break
            
        }
        
    }
    
}


extension ViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
