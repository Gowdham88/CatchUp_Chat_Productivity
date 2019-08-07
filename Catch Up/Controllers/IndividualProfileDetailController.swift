//
//  IndividualProfileDetailController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/29/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class IndividualProfileDetailController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return self.style
    }
    
    var style: UIStatusBarStyle = .lightContent

    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var onlineStatus: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var onlineStatusImage: UIImageView!
    
    @IBOutlet weak var circularView1: UIView!
    
    @IBOutlet weak var circularView2: UIView!

    
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    @IBOutlet weak var curvedBackupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.style == .default {
            
            self.style = .lightContent
        }
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            
        }
        
          self.navigationController?.navigationBar.barStyle = .black
        
        curvedBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
