//
//  NewGroupTableCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/22/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class NewGroupTableCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    @IBOutlet weak var selectStatusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
