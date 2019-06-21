//
//  popUpTableCell.swift
//  Catch Up
//
//  Created by CZSM G on 28/05/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//


import UIKit

class popUpTableCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var popupOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if(self.iconImage?.image != nil){
            
            let cellFrame = self.frame
            let textLabelFrame = self.popupOption?.frame
            let imageViewFrame = self.iconImage?.frame
            
            self.iconImage?.contentMode = .scaleAspectFit
            self.iconImage?.clipsToBounds = true
            self.iconImage?.frame = CGRect(x: (imageViewFrame?.origin.x)!, y: (imageViewFrame?.origin.y)! + 1, width: 25, height: 25)
            
            self.popupOption!.frame = CGRect(x: 60 + (imageViewFrame?.origin.x)! , y: (textLabelFrame?.origin.y)!-7, width: cellFrame.width-(70 + (imageViewFrame?.origin.x)!), height: textLabelFrame!.height)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
