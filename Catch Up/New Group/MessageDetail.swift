//
//  MessageDetail.swift
//  Catch Up
//
//  Created by Siva on 26/06/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageDetail {
    
    
    private var _recipient: String!
    private var _messageKey: String!
    private var _messageRef: DatabaseReference!
    private var _recentMessage: String!
    private var _receipientName: String!
    private var _receipientImage: String!
    private var _receivedTimeStamp: TimeInterval!
   

    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var recipient: String {
        return _recipient
    }

    var messageKey: String {
        return _messageKey
    }

    var messageRef: DatabaseReference {
        return _messageRef
    }
    
    var recentMessage: String {
        
        return _recentMessage
    }
    
    var receipientName: String {
        
        return _receipientName
    }
    
    
    var receipientImage: String {
        
        return _receipientImage
    }
    
    var receivedTimeStamp: TimeInterval {
        
        return _receivedTimeStamp
    }
    
   
    
    init(recipient: String) {
        
        _recipient = recipient
        
    }

    init (messageKey: String, messageData: Dictionary<String, AnyObject>) {

        _messageKey = messageKey
        
        if let recipient = messageData["recipient"] as? String {
            
            _recipient = recipient
            
        }
        
        if let recent = messageData["lastmessage"] as? String {
            
            _recentMessage = recent
        }
        
//        _receipientName = userName
//
//        _receipientImage = userPhoto
//
        if let time = messageData["timestamp"] as? TimeInterval {
            
            _receivedTimeStamp = time
        }
        
        _messageRef = Database.database().reference().child("recipient").child(_messageKey)
        
        
    }

//        init (messageKey: String, messageData: Dictionary<String, AnyObject>,userName: String,userPhoto: String,timeStamp: String)
}
