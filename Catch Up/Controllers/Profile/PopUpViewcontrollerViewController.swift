//
//  PopUpViewcontrollerViewController.swift
//  Catch Up
//
//  Created by CZSM4 on 23/05/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import BottomPopup

class PopUpViewcontrollerViewController: BottomPopupViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var shouldDismissInteractivelty: Bool?
    
    let kHeightMaxValue: CGFloat = 600
    let kTopCornerRadiusMaxValue: CGFloat = 20
    let kPresentDurationMaxValue = 3.0
    
    let kDismissDurationMaxValue = 3.0
    
    var height: CGFloat = 350
    var topCornerRadius: CGFloat = 20
    var presentDuration: Double = 0.3
    var dismissDuration: Double = 0.2
    var PageHeader = String()
    
    var EditProfileIcons = [UIImage(named: "camera-2"), UIImage(named: "image-1"), UIImage(named: "Delete")]
    var EditProfileTitle = ["Camera", "Gallery", "Delete"]
    var ModeTitle = ["Light mode", "Dark mode"]
    var ModeImages = [UIImage(named: "sun"), UIImage(named: "moon")]
    
    @IBOutlet weak var alertHeader: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        alertHeader.text = PageHeader
    }
    
    override func getPopupHeight() -> CGFloat {
        
        switch PageHeader {
            
        case "Chat"  :
            
            return 0
            
//        case "Invite Friends"  :
//            return 0
            
        case "Theme"  :
            
            
            
            return 1
            
//        case "Help"  :
//            return 0
            
        case "Edit Profile"  :
            
            myTableView.alpha = 1
            myCollectionView.alpha = 0
            
            return 1
            
            
        default:
            return height

        }
        
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch PageHeader {
            
        case "Chat"  :
            return 0
            
        case "Invite Friends"  :
            return 0
            
        case "Theme"  :
            
            myTableView.alpha = 1
            myCollectionView.alpha = 0
            
            return 1
            
        case "Help"  :
            return 0
            
        case "Edit Profile"  :
            
            myTableView.alpha = 1
            myCollectionView.alpha = 0
            
            return 1
            
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch PageHeader {
            
        case "Chat"  :
            return 0
            
        case "Invite Friends"  :
            return 0
            
        case "Theme"  :
            return 2
            
        case "Help"  :
             return 0
            
        case "Edit Profile"  :
             return 3
            
        default:
            return 0
            
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
        
    }

   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! popupTableViewcell
        
        
        switch PageHeader {
            
        case "Theme"  :
            
            cell.iconImage.image = ModeImages[indexPath.row]
            cell.popupOption.text = ModeTitle[indexPath.row]
            return cell
            
        case "Edit Profile"  :

            cell.iconImage.image = EditProfileIcons[indexPath.row]
            
            cell.popupOption.text = EditProfileTitle[indexPath.row]
            
            if indexPath.row == 2 {
                
                cell.popupOption.textColor = .red
                
            }
            
            return cell
            
        default:
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch PageHeader {
            
        case "Chat"  :
            return 5
            
        case "Invite Friends"  :
            return 0
            
        case "Theme"  :
            return 0
            
        case "Help"  :
            return 0
            
        case "Edit Profile"  :
            return 0
            
        default:
            return 0
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch PageHeader {
            
        case "Chat"  :
            
            myTableView.alpha = 0
            myCollectionView.alpha = 1
            
            return 1
            
        case "Invite Friends"  :
            return 0
            
        case "Theme"  :
            return 0
            
        case "Help"  :
            return 0
            
        case "Edit Profile"  :
            return 0
            
        default:
            return 0
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PopupCollectionViewCell
        
        switch PageHeader {
            
        case "Chat"  :
            
//            cell.iconImage.image = EditProfileIcons[indexPath.row]
//
//            cell.popupOption.text = EditProfileTitle[indexPath.row]
            
            cell.myLabel.text = "\(indexPath.row)"
            
            return cell
            
        default:
            return cell
            
        }
        
    }

}
