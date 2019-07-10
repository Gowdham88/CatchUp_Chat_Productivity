//
//  CutomCameraViewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/17/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import CameraManager


class CutomCameraViewController: UIViewController {

    @IBOutlet var cameraView: UIView!
    
    @IBOutlet var closeButton: UIButton!
    
    @IBOutlet var flashButton: UIButton!
    
    @IBOutlet var openCapturedImages: UIImageView!
    
    @IBOutlet var frontOrBackCameraButton: UIButton!
    
    let cameraManager = CameraManager()
    
    var isFrontCamera : Bool = false
    
    var isFlashModeOn : Bool = false

    
    
    @IBOutlet var captureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
          
            StatusbarView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
            
        }
        
        captureButton.layer.cornerRadius = captureButton.frame.height/2
        flashButton.alpha = 0.5
        
        cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.cameraOutputMode = .stillImage
        cameraManager.shouldEnableTapToFocus = true
        cameraManager.shouldEnablePinchToZoom = true
        cameraManager.shouldEnableExposure = true
        cameraManager.cameraDevice =  .back
        cameraManager.writeFilesToPhoneLibrary = true
        cameraManager.imageAlbumName = "Catch Up"
        cameraManager.showAccessPermissionPopupAutomatically = true
//        cameraManager.shouldFlipFrontCameraImage = false
        
        
        closeButton.addTarget(self, action: #selector(didTappedClose(sender:)), for: .touchUpInside)
        
        flashButton.addTarget(self, action: #selector(didTappedFlash(sender:)), for: .touchUpInside)
        
        frontOrBackCameraButton.addTarget(self, action: #selector(didTappedFrontOrBackCamera(sender:)), for: .touchUpInside)
        
        captureButton.addTarget(self, action: #selector(didTappedCapture(sender:)), for: .touchUpInside)
        

        
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
}

extension CutomCameraViewController {
    
    @objc func didTappedClose(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTappedFlash(sender: UIButton) {
        
        if isFlashModeOn == true {

            cameraManager.flashMode = .off

            isFlashModeOn = false

            flashButton.alpha = 0.5

        }else {

            cameraManager.flashMode = .on

             isFlashModeOn = true

            flashButton.alpha = 1
        }

        
    }
    
    @objc func didTappedCapturedImages(sender: UITapGestureRecognizer) {
        
        
    }
    
    @objc func didTappedFrontOrBackCamera(sender: UIButton) {
        
        if isFrontCamera == false {
            
             cameraManager.cameraDevice = .front
            
            isFrontCamera = true
            
        }else {
            
             cameraManager.cameraDevice = .back
            
            isFrontCamera = false
        }
   
    }
    
    @objc func didTappedCapture(sender: UIButton) {
        
        cameraManager.cameraOutputMode = .stillImage
        
        cameraManager.capturePictureWithCompletion({ result in
            
            switch result {
           
            case .failure:
                // error handling
                print("error occured")
                
            case .success(let content):
              
                self.openCapturedImages.image = content.asImage
               
                self.openCapturedImages.contentMode = .scaleAspectFit
                
                let sb = UIStoryboard(name: "Chat", bundle: nil)
                
                let vc = sb.instantiateViewController(withIdentifier: "CameraPreviewController") as! CameraPreviewController
                
                vc.receiveImage = self.openCapturedImages.image!
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
}
