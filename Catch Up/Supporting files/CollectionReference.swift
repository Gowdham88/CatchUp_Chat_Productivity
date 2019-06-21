//
//  CollectionReference.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/18/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum CollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


//func reference(_ collectionReference: CollectionReference) -> CollectionReference {
//    var ref = Database.database().reference()
//   
//    return ref.
//}
