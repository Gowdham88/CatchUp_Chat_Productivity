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
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImgView.setRounded()
        
        dayLbl.layer.cornerRadius = 10
        dayLbl.layer.borderWidth = 1.0
        dayLbl.layer.borderColor = UIColor.yellow.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
        
        taskView.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)

    }
    
//     func layoutSubviews() {
//        super.layoutSubviews()
//        taskView.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
//    }
}
//extension
extension UIImageView {
    
    func setRounded() {
       
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
}

//extension UIView {
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
//}
