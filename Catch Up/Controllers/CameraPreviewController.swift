//
//  CameraPreviewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/17/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import CameraManager


class CameraPreviewController: UIViewController {

    @IBOutlet var previewImage: UIImageView!
    
    @IBOutlet var buttonBack: UIButton!
    
    @IBOutlet var buttonSend: UIButton!
    
    var receiveImage = UIImage()
    
    let cameraManager = CameraManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
            
        }
        
        previewImage.image = receiveImage
        
//        previewImage.contentMode = .scaleAspectFill
        
//      let imageSize =  aspectScaledImageSizeForImageView(iv: previewImage, im: previewImage.image!)
        
//        previewImage.frame.size = imageSize
//
//        if previewImage.image!.size > CGSize(width: 200, height: 300) {
//
//            previewImage.contentMode = .scaleAspectFit
//        }
        
//        float aspectRatio = img.size.width/img.size.height;
//        float requiredHeight = self.view.bounds.size.width / aspectRatio;

        
        
        
//        let aspectRatio = CGFloat((previewImage.image?.size.width)!)/CGFloat((previewImage.image?.size.height)!)
//        let req = self.view.bounds.size.width / aspectRatio
//
//        print("reqqq",req)
//
       
//        previewImage.frame.size = imageSizeAspectFit(imgview: previewImage)
        
        previewImage.frame.size = previewImage.aspectFillSize
        
        guard let validImage = previewImage.image else {
            return
        }
        
        if cameraManager.cameraDevice == .front {
            
            switch validImage.imageOrientation {
                
            case .up, .down:
                
                self.previewImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            default:
                break
            }
        }
        
        previewImage.clipsToBounds = true
        
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedSend(_ sender: Any) {
        
        
    }
  
}

extension UIImageView {
    
    /// Find the size of the image, once the parent imageView has been given a contentMode of .scaleAspectFit
    /// Querying the image.size returns the non-scaled size. This helper property is needed for accurate results.
    var aspectFitSize: CGSize {
        guard let image = image else { return CGSize.zero }
        
        var aspectFitSize = CGSize(width: frame.size.width, height: frame.size.height)
        let newWidth: CGFloat = frame.size.width / image.size.width
        let newHeight: CGFloat = frame.size.height / image.size.height
        
        if newHeight < newWidth {
            aspectFitSize.width = newHeight * image.size.width
        } else if newWidth < newHeight {
            aspectFitSize.height = newWidth * image.size.height
        }
        
        return aspectFitSize
    }
    
    /// Find the size of the image, once the parent imageView has been given a contentMode of .scaleAspectFill
    /// Querying the image.size returns the non-scaled, vastly too large size. This helper property is needed for accurate results.
    var aspectFillSize: CGSize {
        guard let image = image else { return CGSize.zero }
        
        var aspectFillSize = CGSize(width: frame.size.width, height: frame.size.height)
        let newWidth: CGFloat = frame.size.width / image.size.width
        let newHeight: CGFloat = frame.size.height / image.size.height
        
        if newHeight > newWidth {
            aspectFillSize.width = newHeight * image.size.width
        } else if newWidth > newHeight {
            aspectFillSize.height = newWidth * image.size.height
        }
        
        return aspectFillSize
    }
    
}

