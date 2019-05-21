//
//  CreateProfileController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class CreateProfileController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var gradientCurveView: GradientView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameField.delegate = self
        imagePicker.delegate = self
        roundedTop(targetView: gradientCurveView, desiredCurve: 1)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
        // profile image tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        profileImageView.isUserInteractionEnabled = true
        tapGesture.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(tapGesture)
        
        // nav bar settings
 
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func imageTapped(gesture: UITapGestureRecognizer) {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {
            
            self .present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didTappedSubmit(_ sender: Any) {
        
        let userName = nameField.text
        
        UserDefaults.standard.set(userName, forKey: "name")

    }
    
    func roundedTop(targetView:UIView?, desiredCurve:CGFloat?){
        
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x:bounds.origin.x - offset / 2,y: bounds.origin.y, width : bounds.size.width + offset, height :bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        targetView!.layer.mask = maskLayer
    }
}

extension CreateProfileController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.submitButton.frame.origin.y = self.submitButton.frame.origin.y - 280
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.submitButton.frame.origin.y = self.submitButton.frame.origin.y + 280
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameField.resignFirstResponder()
    }
}

extension CreateProfileController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            profileImageView.contentMode = .scaleToFill
            
            profileImageView.image = pickedImage
        }
        
    }
}
