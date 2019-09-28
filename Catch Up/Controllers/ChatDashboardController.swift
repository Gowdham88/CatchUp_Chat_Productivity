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
import SDWebImage
import RealmSwift


class ChatDashboardController: UIViewController {
    
    var getDeviceToken: String?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var navigationSubView: GradientView!
    
    @IBOutlet weak var tempView: UIView!
    
    var messageDetail = [MessageDetail]()
//    var detail: MessageDetail!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    var recipient : String!
    var messageId: String!
//    var userContactName: String!
//    var userContactImage: String!
    var dic : [String : String] = [:]
    var cont = ["one",
                "two",
                "three"]
    
    let groupMembersDict = [
        "919": "participant",
        "111": "observer",
        "222": "participant"
    ]
    
    let time = [12312213132]
    var inboxMessage = InboxMessages()
    var outboxMessage = OutboxMessages()
    var messageTEXT :String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return self.style
    }
    
    @IBOutlet weak var addContactButton: UIButton!
    
    var style: UIStatusBarStyle = .lightContent
    
    var sendPhotoURL: URL?
    
    var sendUserName: String?
    
    var receipientArray = [String]()
    
    @IBOutlet var topNavView: GradientView!
    
    @IBOutlet var tableBackUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /* As of now Commenting the realm codes
        
        let realm = try! Realm()
        
        print("realm location:::\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        
        // inbox messages
        
        inboxMessage.messageText = "Diva"
        inboxMessage.sender = "yIvq1mQxjfZpjs1ybRTTlDOmUKV2"
        //timestamp
//        for timeDataa in time {
//            inboxMessage.chatCreatedDateTimee.append(timeDataa)
//        }
        inboxMessage.chatCreatedDateTimee = Date()
        inboxMessage.chatId = "+918000080000"
        inboxMessage.from = "+918000080000"
        inboxMessage.chatMessageId = "medbef3c589f0bf2bf05cea434b5ee913"
        inboxMessage.chatAttachment = "1GKxkrl8nRdA3nt86HGMx6upovX2/7675800694735984919_IMG-20190716025133-1563268893829.jpg"
        inboxMessage.chatAttachmentCaption = ""
        inboxMessage.chatMessageType = "TEXT"
        inboxMessage.chatWindowName = "Siva Ns"
        inboxMessage.deleted.value = false
        inboxMessage.group.value = false
        
        for member in groupMembersDict {
            let aGroup = GroupData(withNum: member.key, andType: member.value)
            inboxMessage.groupMemberss.append(aGroup)
        }
        inboxMessage.groupMemebersCount.value = 1
        inboxMessage.hightlight = 213123
        inboxMessage.messageChatStatus = "INPROGRESS"
        inboxMessage.messageOrigin = "OTHER"
        inboxMessage.participantAllowedToEditGroupInfo.value = true
        inboxMessage.participantAllowedToMessage.value = true
        inboxMessage.task.value = true
        //to
        for toMember in cont {
//            let toDataValue = toData(withNum: toMember)
            inboxMessage.to.append(toMember)
        }
        inboxMessage.uploadComplete.value = true


        // outbox messages
        
        outboxMessage.messageText = "Diva"
        outboxMessage.sender = "yIvq1mQxjfZpjs1ybRTTlDOmUKV2"
        //timestamp
//        for timeDataa in time {
//            outboxMessage.chatCreatedDateTimee.append(timeDataa)
//        }
        outboxMessage.chatCreatedDateTimee = Date()
        outboxMessage.chatId = "+918000080000"
        outboxMessage.from = "+918000080000"
        outboxMessage.chatMessageId = "medbef3c589f0bf2bf05cea434b5ee913"
        outboxMessage.chatAttachment = "1GKxkrl8nRdA3nt86HGMx6upovX2/7675800694735984919_IMG-20190716025133-1563268893829.jpg"
        outboxMessage.chatAttachmentCaption = ""
        outboxMessage.chatMessageType = "TEXT"
        outboxMessage.chatWindowName = "Siva Ns"
        outboxMessage.deleted.value = false
        outboxMessage.group.value = false
        
        for member in groupMembersDict {
            let aGroup = GroupDataOutbox(withNum: member.key, andType: member.value)
            outboxMessage.groupMemberss.append(aGroup)
        }
        outboxMessage.groupMemebersCount.value = 1
        outboxMessage.hightlight = 213123
        outboxMessage.messageChatStatus = "INPROGRESS"
        outboxMessage.messageOrigin = "OTHER"
        outboxMessage.participantAllowedToEditGroupInfo.value = true
        outboxMessage.participantAllowedToMessage.value = true
        outboxMessage.task.value = true
        //to
        for toMember in cont {
            //            let toDataValue = toData(withNum: toMember)
            outboxMessage.to.append(toMember)
        }
        outboxMessage.uploadComplete.value = true
    
        try! realm.write {

            realm.add(inboxMessage)
            realm.add(outboxMessage)
        }
        
          samplerealmDataRetrieve()
        
        */
        
        
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
        
        // tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapUserImage(gesture:)))
        tap.numberOfTapsRequired = 1
        self.userProfileImage.isUserInteractionEnabled = true
        self.userProfileImage.addGestureRecognizer(tap)
        
        
//       print("max y of nav view \(topNavView.frame.maxY) and view frame \(self.view.frame.height)")
//        
//        let tableBackUpHeight = self.view.frame.height - topNavView.frame.maxY
//        
//        chatTableView.frame.size.height = tableBackUpHeight
//        
//        print("chat table view frame \(chatTableView.frame.size.height)")
//        
//        tableBackUpView.frame = CGRect(x: 0, y: topNavView.frame.maxY, width: self.view.frame.width, height: tableBackUpHeight)
        
        
      
//        sampleMessageFilterRealm()
        
    }//viewdidload
    
    
    @objc func tapUserImage(gesture: UITapGestureRecognizer) {
        
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            vc.userImageURL = sendPhotoURL ?? nil
            vc.userName = sendUserName ?? "clay"
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func samplerealmDataRetrieve(){

        let realm = try! Realm()

        let messageResults = realm.objects(InboxMessages.self)
        
        for msg in messageResults {
//            print("message text",msg.messageText!)
            messageTEXT = msg.chatMessageId
            for group in msg.groupMemberss {
                print("message group data",group.num, group.type)
            }
        }
        
    }
    
    func sampleMessageFilterRealm(){
        let realm = try! Realm()
//        let primaryKey = "medbef3c589f0bf2bf05cea434b5ee913"
        for item in realm.objects(InboxMessages.self).filter("chatMessageId == primaryKey") {
            print("item",item)
        }

//        let data = realm.objects(InboxMessages.self).filter("chatMessageId == medbef3c589f0bf2bf05cea434b5ee913")
//
//        if data != nil{
//
//            print("data values exists")
//
//        }else{
//
//            print("data values not found")
//
//
//        }
//        outboxMessage  = realm.where(inboxMessage.chatMessageId).equalTo("account.accountNumber", 1234567890).findAll();
        
        
//        print("filter query::", myFilter!)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NavProfileData()
        
        
        print("current user uid in dashboard screen:::", currentUser!)

        
        let idss = UUID().uuidString
        
        print("idss:::\(String(describing: idss))")
        let ref = Database.database().reference().child("user").child(currentUser!).child("inbox").queryOrdered(byChild: "timestamp")

        
//        let ref = Database.database().reference().child("user").child(currentUser!).child("messages").queryOrdered(byChild: "timestamp") //original
    
        ref.observe(.value) { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                self.messageDetail.removeAll()

                for data in snapshot.reversed() {
                    
                    if let messageDict = data.value as? Dictionary<String, AnyObject> {
                        
                        let key = data.key
                        
                        let info = MessageDetail(messageKey: key, messageData: messageDict)
                        
                        print("info::\(info.messageKey)")
            
                        self.messageDetail.append(info)
                        
                        
                    }
                }
                
                 self.chatTableView.reloadData()
                
            }

        }
        
    }//viewdidappear
    
    
    func NavProfileData(){
        
        let recipientData = Database.database().reference().child("user").child(currentUser!)
        
        recipientData.observeSingleEvent(of: .value) { (snapshot) in
            
//            let data = snapshot.value as! Dictionary<String, AnyObject>
            
            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                
                for item in data {
                    
                    if item.key == "userPhotoThumbnail" {
                        
                        if let photoUrl = URL(string: item.value as! String) {
                            
                            self.sendPhotoURL = photoUrl
                            
                            self.userProfileImage.sd_setImage(with: photoUrl)
                            
                        }
                    }
                    
                    if item.key == "userName" {
                        
                        if let username = item.value as? String {
                            
                            self.sendUserName = username
                        }
                    }
                    
                }
            }
        }
        
    }
    

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
        
        print("message detail count \(messageDetail.count)")
        
        return messageDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageDet = messageDetail[indexPath.row]
        
        print("message det \(messageDet.recipient)")
        
        if let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell") as? ChatTableViewCell {
            
            if receipientArray.contains(messageDet.recipient) {
                
                cell.configureCell(messageDetail: messageDet)

            }
            
            receipientArray.append(messageDet.recipient)
            
            return cell
            
        } else {
            
            return ChatTableViewCell()

        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        recipient = messageDetail[indexPath.row].recipient
        messageId = messageDetail[indexPath.row].messageRef.key
        
//        userContactName = messageDetail[indexPath.row].receipientName
//        userContactImage = messageDetail[indexPath.row].receipientImage
//
//        print("user Contact Name:: recent \(String(describing: userContactName))")
//        print("user Contact Image:: recent \(String(describing: userContactImage))")
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "MainChatScreenController") as! MainChatScreenController
        
        if let receip = recipient {
            
            vc.recipient = receip
        }
        
        vc.messageId = messageId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}


