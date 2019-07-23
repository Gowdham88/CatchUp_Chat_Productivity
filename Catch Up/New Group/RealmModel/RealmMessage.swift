//
//  RealmMessage.swift
//  Catch Up
//
//  Created by Paramesh V on 16/07/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMessages: Object {
    
    @objc dynamic var messageText : String?
    @objc dynamic var sender: String?
    let chatCreatedDateTimee = List<timeStampValue>()
    @objc dynamic var chatId: String?
    @objc dynamic var from: String?
    @objc dynamic var chatMessageId: String?
    @objc dynamic var chatAttachment: String?
    @objc dynamic var chatAttachmentCaption: String?
    @objc dynamic var chatMessageType: String?
    @objc dynamic var chatWindowName: String?
    let deleted = RealmOptional<Bool>()
    let group = RealmOptional<Bool>()
    let groupMemberss = List<GroupData>()

    let groupMemebersCount = RealmOptional<Int>()
    @objc dynamic var hightlight: Int = 0
    @objc dynamic var messageChatStatus: String?
    @objc dynamic var messageOrigin: String?
    let participantAllowedToEditGroupInfo = RealmOptional<Bool>()
    let participantAllowedToMessage = RealmOptional<Bool>()
    @objc dynamic var task: Bool = false
    let to = List<toData>()
//    let to = List<String>()

    let uploadComplete = RealmOptional<Bool>()

}

class timeStampValue: Object {
    
    let timestamp = RealmOptional<Int>()
    
}

class toData: Object {
    
    @objc dynamic var num1 = ""
    convenience init(withNum: String) {
        self.init()
        self.num1 = withNum
    }
  
}

class GroupData: Object {
    @objc dynamic var num = ""
    @objc dynamic var type = ""
    
    convenience init(withNum: String, andType: String) {
        self.init()
        self.num = withNum
        self.type = andType
    }
}
