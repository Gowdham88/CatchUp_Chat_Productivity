//
//  TaskViewController.swift
//  Catch Up
//
//  Created by User on 23/5/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var dateTargetLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImgView.setRounded()
        
    }
}

extension UIImageView {
    
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
