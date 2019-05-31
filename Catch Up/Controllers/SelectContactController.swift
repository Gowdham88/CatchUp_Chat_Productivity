//
//  SelectContactController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

class SelectContactController: UIViewController {
    
    @IBOutlet weak var selectContactTableView: UITableView!
    
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var navigationTempView: UIView!
    
    @IBOutlet weak var addNewGroup: UIView!
    
    @IBOutlet weak var addPeopleButton: UIButton!
    
var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        addNewGroup.layer.cornerRadius = 20
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
//            setGradientBackground(view: StatusbarView)
            
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
        
      

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            getContacts()
            
        }
    }
    

    
    
    @IBAction func didTappedAddPeople(_ sender: Any) {
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    //    func setGradientBackground(view: UIView) {
//
//        let colorTop =  UIColor(hex: "5FABFF").cgColor
//
//        let colorBottom = UIColor(hex: "007AFF").cgColor
//
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [colorTop, colorBottom]
//
////        gradientLayer.locations = [0.5, 0.0]
//
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
//
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
//
//        gradientLayer.frame = view.bounds
//
//        view.layer.insertSublayer(gradientLayer, at:0)
//    }
    
 
}

extension UIView {
    
    func setGradientBackground(view: UIView) {
        
        let colorTop =  UIColor(hex: "5FABFF").cgColor
        
        let colorBottom = UIColor(hex: "007AFF").cgColor
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [colorTop, colorBottom]
        
        //        gradientLayer.locations = [0.5, 0.0]
        
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension SelectContactController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = selectContactTableView.dequeueReusableCell(withIdentifier: "cell") as! SelectContactTableViewCell
        
        cell.userName.text = contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName
        
        
       
         let phone = contacts[indexPath.row].phoneNumbers
        
        for item in phone {
            
            print(item.value.stringValue)
            
            cell.userContactNumber.text = item.value.stringValue
            
        }
        
//            print("number val \(phone[indexPath.row].value)")
        
//        let number = phone[indexPath.row].value.stringValue
        
//        print("phone numbers \(number)")
        
      
//           cell.userContactNumber.text = "\(dsw)"
        

        return cell
    }
    
    
    
    
}

extension SelectContactController {
    
    func requestAccess() {
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                DispatchQueue.main.async {
                    self.presentSettingsActionSheet()
                }
                return
            }
        }
    }
    
    func presentSettingsActionSheet() {
        
        let alert = UIAlertController(title: "Permission to Contacts", message: "This app needs access to contacts in order to ...", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func getContacts(){
        
        let contactStore = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.givenName
        
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                self.contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
    }
}
