//
//  RealmMessage.swift
//  Catch Up
//
//  Created by Paramesh V on 16/07/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class InboxMessages: Object {
    
    @objc dynamic var messageText : String?
    @objc dynamic var sender: String?
//    let chatCreatedDateTimee = List<timeStampValue>()
//    let chatCreatedDateTimee = List<Int>()
    @objc dynamic var chatCreatedDateTimee = Date()

//    let chatCreatedDateTimee = RealmOptional<Int>()
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
    let task = RealmOptional<Bool>()
//    let to = List<toData>()
    let to = List<String>()

    let uploadComplete = RealmOptional<Bool>()
    
    let userSelect = List<RecentChatModelRealm>()
//    override class func primaryKey() -> String? {
//        return "chatMessageId"
//    }

}

//class timeStampValue: Object {
//
//
//    let num1 = RealmOptional<Int>()
////    convenience init(withNum: Int) {
////        self.init()
////        self.num1 = withNum
////    }
//
//}

//class toData: Object {
//
//    @objc dynamic var num1 = ""
//    convenience init(withNum: String) {
//        self.init()
//        self.num1 = withNum
//    }
//
//}

class GroupData: Object {
    @objc dynamic var num = ""
    @objc dynamic var type = ""
    
    convenience init(withNum: String, andType: String) {
        self.init()
        self.num = withNum
        self.type = andType
    }
}
