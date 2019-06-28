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
        let recipientData = Database.database().reference().child("user").child(messageDetail.recipient)
        recipientData.observeSingleEvent(of: .value) { (snapshot) in
            
            let data = snapshot.value as! Dictionary<String, AnyObject>
            let username = data["useraName"]
            let userImg = data["userPhotoThumbnail"]
            
            self.recipientName.text = username as? String
            
            let ref = Storage.storage().reference(forURL: userImg as! String)
            
            ref.getData(maxSize: 100000, completion: { (data, error) in
                
                if error != nil {
                    
                    print("could not load image")
                } else {
                    
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            
                            self.recipientImg.image = img
                        }
                    }
                }
                
            })
            
         
            
        }
        
    }//configureCell

}
