//
//  GroupDetailTableCell.swift
//  Catch Up
//
//  Created by Suraj B on 29/05/2019.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class GroupDetailTableCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        
        self.selectedBackgroundView = UIView()
        
        self.selectionStyle = .default
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.selectedBackgroundView!.backgroundColor = selected ? .clear : nil

    }

}
