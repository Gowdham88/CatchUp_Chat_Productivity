//
//  ChatDashboardController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import Firebase
import SwiftKeychainWrapper

class ChatDashboardController: UIViewController {
    
    var getDeviceToken: String?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var navigationSubView: GradientView!
    
    @IBOutlet weak var tempView: UIView!
    
    var messageDetail = [MessageDetail]()
    var detail: MessageDetail!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    var recipient : String!
    var messageId: String!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return self.style
    }
    
    @IBOutlet weak var addContactButton: UIButton!
    
    var style: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("current user uid in dashboard screen:::", currentUser!)
        Database.database().reference().child("user").child(currentUser!).child("messages").observe(.value) { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
         
                self.messageDetail.removeAll()
                
                for data in snapshot {
                    
                    if let messageDict = data.value as? Dictionary<String, AnyObject> {
                        
                        let key = data.key
                        
                        let info = MessageDetail(messageKey: key, messageData: messageDict)
                        
                        self.messageDetail.append(info)
                    }
                }
                
            }
            
        }
        
        print("device token is",getDeviceToken)
        
        if self.style == .default {
            
            self.style = .lightContent
        }
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
           
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        
        self.navigationController?.navigationBar.barStyle = .black
       
        tempView.roundCorners(corners: [.topLeft, .topRight], radius: 17.0)
        chatTableView.roundCorners(corners: [.topLeft, .topRight], radius: 17.0)
        userProfileImage.layer.cornerRadius = userProfileImage.frame.height / 2
        
        
    }//viewdidload
    

    @IBAction func didTappedAddContact(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectContactController") as! SelectContactController
        vc.isForward = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}//class

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowOpacity = 10.0
//        layer.shadowRadius = 4.0
    }
}

extension ChatDashboardController: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageDet = messageDetail[indexPath.row]
        
        if let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell") as? ChatTableViewCell {
            
            cell.configureCell(messageDetail: messageDet)
            
            return cell
        } else {
            
            return ChatTableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        recipient = messageDetail[indexPath.row].recipient
        messageId = messageDetail[indexPath.row].messageRef.key
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "MainChatScreenController") as! MainChatScreenController
        
        vc.recipient = recipient
        vc.messageId = messageId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}
