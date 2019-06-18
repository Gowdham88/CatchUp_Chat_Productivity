//
//  SelectContactTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class SelectContactTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userContactNumber: UILabel!
    
    @IBOutlet weak var selectContactButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }

    @IBAction func didTappedSelectContact(_ sender: Any) {
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
