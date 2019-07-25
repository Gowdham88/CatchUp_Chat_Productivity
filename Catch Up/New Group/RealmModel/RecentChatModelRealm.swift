//
//  RecentChatModel.swift
//  Catch Up
//
//  Created by Paramesh V on 24/07/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class RecentChatModelRealm: Object {
    
    @objc dynamic var sender = String()
    @objc dynamic var fromId = String()
    @objc dynamic var toId = String()
    @objc dynamic var lastMessage = String()
    @objc dynamic var profileImage = NSData()
//    let msgs = List<InboxMessages>()
  
//    override class func primaryKey() -> String {
//        return "sender"
//    }

    
}
