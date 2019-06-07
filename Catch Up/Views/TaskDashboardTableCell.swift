//
//  TaskDashboardTableCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/6/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class TaskDashboardTableCell: UITableViewCell {
    
    @IBOutlet weak var taskMainView: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        taskMainView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 7.0)
        
        taskMainView.layer.cornerRadius = 7.0
        
        taskMainView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
