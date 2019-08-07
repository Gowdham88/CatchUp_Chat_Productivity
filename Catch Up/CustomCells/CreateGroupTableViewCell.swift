//
//  CreateGroupTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/4/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class CreateGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userContactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
