//
//  MainChatScreenController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/16/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import CameraManager



class MainChatScreenController: UIViewController {
    
   // navigation outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navProfileImage: UIImageView!
    @IBOutlet weak var groupButton: UIButton!
    
    @IBOutlet weak var navigationView: GradientView!
    
    @IBOutlet weak var threadBackupView: UIView!
    
    @IBOutlet weak var threadMainImageView: UIImageView!
    
    @IBOutlet weak var bottomBarView: UIView!
    
    
    // bottom bar outlets
    
    @IBOutlet weak var emojiButton: UIButton!
    
    @IBOutlet weak var typeMessageTextField: UITextField!
    
    @IBOutlet weak var attachmentButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var cameraManager : CameraManager!
    
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        threadBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        threadMainImageView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        bottomBarView.roundCorners(corners: [.topLeft, .topRight], radius: 17.0)
        
        navProfileImage.layer.cornerRadius = navProfileImage.frame.height/2
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
          
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        bottomBarView.layer.masksToBounds = false
        
        picker?.delegate = self
        
        cameraManager = CameraManager()
        
        cameraManager.shouldFlipFrontCameraImage = true
    
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedEmoji(_ sender: Any) {
        
        
    }
    
    @IBAction func didTappedAttchments(_ sender: Any) {
        
        // for image
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        addChild(myPickerController)
        threadMainImageView.addSubview(myPickerController.view)
        
        myPickerController.view.frame = threadMainImageView.bounds
        
        myPickerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //        self.present(myPickerController, animated: true, completion: nil)
        
        myPickerController.didMove(toParent: self)
    }
    
    @IBAction func didTappedCamera(_ sender: Any) {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            cameraManager.addPreviewLayerToView(self.view)
            cameraManager.shouldFlipFrontCameraImage = true
            picker!.sourceType = UIImagePickerController.SourceType.camera
            self .present(picker!, animated: true, completion: nil)
        }

   
    }
    
    @IBAction func didTappedAudioRecord(_ sender: Any) {
        
        
        
    }
}

extension MainChatScreenController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
     
        
    }
    
    
    
    
}
