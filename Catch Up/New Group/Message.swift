//
//  Message.swift
//  Catch Up
//
//  Created by Siva on 27/06/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class Message {
    
    
    private var _messageText: String!
    
    private var _sender: String!
    
    private var _messageKey: String!
    
    private var _messageRef: DatabaseReference!
    
    private var _receivedTimeStamp: TimeInterval!
    
    private var _chatId: String!
    
    private var _chatMessageType: String!
    
    private var _from: String!

    
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var messageText: String {
        
        return _messageText
    }
    
    var sender: String {
        
        return _sender
    }
    
    var messageKey: String{
        
        return _messageKey
    }
    
    var receivedTimeStamp: TimeInterval {
        
        return _receivedTimeStamp
    }
    
    init(messageText: String, sender: String) {
        
        _messageText = messageText
        
        _sender = sender
    }
    
    init(messageKey: String, postData: Dictionary<String, AnyObject>) {
        
        _messageKey = messageKey
        
        if let messageText = postData["messageText"] as? String {
            
            _messageText = messageText
        }
        
        if let sender = postData["sender"] as? String {
            
            _sender = sender
        }
        
        if let time = postData["timestamp"] as? TimeInterval {
            
            _receivedTimeStamp = time
        }
        
        _messageRef = Database.database().reference().child("user").child("messages").child(_messageKey)
//        Database.database().reference().child("user").child(currentUser!).child("messages").child(_messageKey)
    }
    
    
}
