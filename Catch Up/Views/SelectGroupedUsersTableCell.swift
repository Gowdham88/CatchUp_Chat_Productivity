//
//  SelectGroupedUsersTableCell.swift
//  Catch Up
//
//  Created by Suraj B on 23/05/2019.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class SelectGroupedUsersTableCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
