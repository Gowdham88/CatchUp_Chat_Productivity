//
//  ChatTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImg.layer.cornerRadius = profileImg.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
