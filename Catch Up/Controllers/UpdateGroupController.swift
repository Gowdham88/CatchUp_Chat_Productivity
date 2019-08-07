//
//  UpdateGroupController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/29/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class UpdateGroupController: UIViewController {
    
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var editCameraButton: UIImageView!
    
    @IBOutlet weak var editNameField: UITextField!
    
    @IBOutlet weak var curvedBackupView: UIView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        curvedBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        userImageView.layer.cornerRadius = userImageView.frame.height/2

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
