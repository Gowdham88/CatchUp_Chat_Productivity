//
//  ProfileTableViewCell.swift
//  Catch Up
//
//  Created by CZSM4 on 22/05/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var ProfileText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconView.layer.borderWidth = 1
        iconView.layer.masksToBounds = false
        iconView.layer.borderColor = UIColor.clear.cgColor
        iconView.layer.cornerRadius = iconView.frame.height/2
        
        iconView.layer.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1).cgColor
        
        iconView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
