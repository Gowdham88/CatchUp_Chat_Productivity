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
    
    let ChooseBackground = Chat_Background()

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
            
            return 300
            
        case "Invite Friends"  :
            return 200
            
        case "Theme"  :
            
            return 250
            
        case "Help"  :
            return 200
            
        case "Edit Profile"  :
            
            return 300
            
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
    
            return 1
            
        case "Help"  :
            return 0
            
        case "Edit Profile"  :
            
            return 1
            
        default:
            return 0
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        
        if indexPath.row != 0 {
            
            switch PageHeader {
                
            case "Chat"  :
                
                if let cell = collectionView.cellForItem(at: indexPath) as? PopupCollectionViewCell {
                    
                    collectionView.allowsMultipleSelection = true
                    
                    collectionView.isUserInteractionEnabled = true
                    
                    ChooseBackground.chooseThemes(BackView: cell.myview, Row: indexPath.row, selectTheme: true)
                    
                   
                    
                }
                                
                
                //            ChooseBackground.chooseThemes(BackView: <#T##UIView#>, Row: <#T##Int#>, selectTheme: <#T##Bool#>)
                
                //
                //                    if let cell = tableView.cellForRow(at: indexPath) {
                //                        cell.accessoryType = .none
                //            }
                
                
            default:
                break
                
            }
        }
        


    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        switch PageHeader {
            
//        case "Chat"  :
//            return 0
//
//        case "Invite Friends"  :
//            return 0
//
        case "Theme"  :
            
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
            }
            
//        case "Help"  :
//            return 0
//
//        case "Edit Profile"  :
//            return 3
            
        default:
            break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            switch PageHeader {
                
                //        case "Chat"  :
                //            return 0
                //
                //        case "Invite Friends"  :
                //            return 0
            //
            case "Theme"  :
                
               
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .checkmark
                    
                }
                
                //        case "Help"  :
                //            return 0
                //
                //        case "Edit Profile"  :
                //            return 3
                
            default:
                break
                
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
            return 6
            
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
            
            if myTableView == nil
            {
                
                myTableView.alpha = 0
            }
            
            if myCollectionView != nil
            {
                
                myCollectionView.alpha = 1
                
            }
            
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
            
            if indexPath.row == 0 {
            
            ChooseBackground.choosecameraImage(BackView: cell.myview)
                
            } else {
                
                ChooseBackground.chooseThemes(BackView: cell.myview, Row: indexPath.row, selectTheme: false)
                
                
            }
            
//            cell.iconImage.image = EditProfileIcons[indexPath.row]
//
//            cell.popupOption.text = EditProfileTitle[indexPath.row]
            
            
            return cell
            
        default:
            return cell
            
        }
        
    }

}
