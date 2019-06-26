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

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var recipientImg: UIImageView!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!
    
    var messageDetail: MessageDetail!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recipientImg.layer.cornerRadius = recipientImg.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
