//
//  Contacts.swift
//  Catch Up
//
//  Created by Siva on 28/06/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class Contacts {
    
    private var _userName: String!
    
    private var _userPhotoThumbnail: String!
    
    private var _userKey: String!
    
    private var _userRef: DatabaseReference!
    
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var userName: String {
        
        return _userName
    }
    
    var userPhotoThumbnail: String {

        return _userPhotoThumbnail
    }
    
    var userKey: String{
        
        return _userKey
    }
    
    init(userName: String, userPhotoThumbnail: String) {
        
            _userName = userName

            _userPhotoThumbnail = userPhotoThumbnail
    }
    
    init(userKey: String, postData: Dictionary<String, AnyObject>) {
        
        _userKey = userKey

         if let userName = postData["userName"] as? String {
        
            _userName = userName
        }
        
        if let userPhotoThumbnail = postData["userPhotoThumbnail"] as? String {
            
            _userPhotoThumbnail = userPhotoThumbnail
        
        }

//            _userRef = Database.database().reference().child("messages").child(_userKey)
            _userRef = Database.database().reference().child("user").child(currentUser!).child("messages").child(_userKey)
        
        }
    }
