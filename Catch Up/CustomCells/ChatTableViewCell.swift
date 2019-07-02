//
//  ChatTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var recipientImg: UIImageView!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!
    
    @IBOutlet var timeStampLabel: UILabel!
    var messageDetail: MessageDetail!
    var userPostKey: DatabaseReference!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recipientImg.layer.cornerRadius = recipientImg.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(messageDetail: MessageDetail){
        
        self.messageDetail = messageDetail
        
        print("printing message detail",messageDetail)
        
//        for item in messageDetail {
//
//            print("valessssssss",ite)
//        }
       
        print("messageDetail.recipient", messageDetail.recentMessage)
       
        let recipientData = Database.database().reference().child("user").child(messageDetail.recipient)
       
        recipientData.observeSingleEvent(of: .value) { (snapshot) in
            
            let data = snapshot.value as! Dictionary<String, AnyObject>
            
            print("printing whole user data",data)
            
            for item in data {
                
                if item.key == "userName" {
                    
                    self.recipientName.text = item.value as? String
                }
                
                if item.key == "userPhotoThumbnail" {
                    
//                    let urll = NSURL(string: item.value as! String)
//
//                    do {
//
//                        let dataa = try Data(contentsOf: urll as! URL)
//
//                        self.recipientImg.image = UIImage(data: dataa)
//                    }
                    
                    if let photoUrl = URL(string: item.value as! String) {
                        
                        self.recipientImg.sd_setImage(with: photoUrl)
                    }
            
                    
                }
                
                if item.key == "messages" {
                    
                    let chatMessages = item.value as? Dictionary<String, AnyObject>
                    
                    print("chat messagessss",chatMessages)
                    
                    for val in chatMessages! {
                        
                        print("key is \(val.key) and val is \(val.value)")
                        
                        if val.key == messageDetail.messageKey {
                            
                            print("recent chat is",val.value)
                            
                            for itemm in (val.value as? Dictionary<String,AnyObject>)! {
                                
                                if itemm.key == "lastmessage" {
                                    
                                    self.chatPreview.text = itemm.value as! String
                                }
                                
                                if itemm.key == "timestamp" {
                                    
                                    let addedTime = itemm.value
                                    let timeinterval : TimeInterval = addedTime as! TimeInterval
                                    let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
                                    let dateFormater : DateFormatter = DateFormatter()
                                    if Calendar.current.isDateInToday(dateFromServer as Date) {
                                        dateFormater.dateFormat = "'Today' hh:mm a"
                                    }
                                    else if Calendar.current.isDateInYesterday(dateFromServer as Date) {
                                        dateFormater.dateFormat = "'Yesterday' hh:mm a"
                                    }
                                    else {
                                        dateFormater.dateFormat = "dd-MM-yyyy"
                                    }
                                    self.timeStampLabel.text = dateFormater.string(from: dateFromServer as Date)
                                }
                            }
                            
                        
                        }
                    }
                    
                    //                    self.chatPreview.text = chatMessages.
                }
            }
            
//            let username = data["useraName"]
//
//            let userImg = data["userPhotoThumbnail"]
//
//            self.recipientName.text = username as? String
//
//            self.chatPreview.text = self.messageDetail.recipient

//            let ref = Storage.storage().reference(forURL: userImg as! String)

//            ref.getData(maxSize: 100000, completion: { (data, error) in
//
//                if error != nil {
//
//                    print("could not load image")
//                } else {
//
//                    if let imgData = data {
//                        if let img = UIImage(data: imgData) {
//
//                            self.recipientImg.image = img
//                        }
//                    }
//                }
//
//            })
            

        }
        
    }//configureCell

}
