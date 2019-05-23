//
//  PopUpViewcontrollerViewController.swift
//  Catch Up
//
//  Created by CZSM4 on 23/05/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import BottomPopup

class PopUpViewcontrollerViewController: BottomPopupViewController {
    
    var shouldDismissInteractivelty: Bool?
    
    let kHeightMaxValue: CGFloat = 600
    let kTopCornerRadiusMaxValue: CGFloat = 20
    let kPresentDurationMaxValue = 3.0
    
    let kDismissDurationMaxValue = 3.0
    
    var height: CGFloat = 350
    var topCornerRadius: CGFloat = 20
    var presentDuration: Double = 0.3
    var dismissDuration: Double = 0.2
    var PageHeader = String()
    
    @IBOutlet weak var alertHeader: UILabel!
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        alertHeader.text = PageHeader
    }
    
    override func getPopupHeight() -> CGFloat {
        return height
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
}
