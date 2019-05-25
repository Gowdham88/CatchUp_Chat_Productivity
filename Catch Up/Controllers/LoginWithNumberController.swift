//
//  LoginWithNumberController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginWithNumberController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var curveView: GradientView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var phoneNumText: UITextField!
    
    var keyboardHeight : CGFloat = 0.0
    
    var isKeyBoardOn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        phoneNumText.delegate = self
        
        roundedTop(targetView: curveView, desiredCurve: 1)
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
        
//        phoneNumText.textColor = UIColor(named: "Light") //
        
        let colorr = UIColor(named: "anotherMode")
        
        phoneNumText.textColor = colorr
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //notification for keyboard
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
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

    @IBAction func didTappedNext(_ sender: Any) {
        
        var phoneNumber : String?
        
        if let num = phoneNumText.text {
        
            phoneNumber = "+91" + num
        
//        phoneNumber = "+91" + "9597496508"
        
        }else {
    
            phoneNumber = "+91" + ""
    
        }
    
        UserDefaults.standard.set(phoneNumber!, forKey: "phone")
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { (verificationID, error) in
            
            if let error = error {
                
                print("error occurred while signing in",error)
                
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

            let sb = UIStoryboard(name: "Auth", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "VerifyOTPVController") as! VerifyOTPVController
            
            vc.keyboardHeight = self.keyboardHeight
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LoginWithNumberController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        phoneNumText.resignFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        phoneNumText.resignFirstResponder()
    }
}

//    func setGradientBackground() {
//
////        let colorTop =  UIColor(hex: "5FABFF").cgColor
////
////        let colorBottom = UIColor(hex: "007AFF").cgColor
//
//        let colorTop =  UIColor.black.cgColor
//
//        let colorBottom = UIColor.red.cgColor
//
//
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [colorTop, colorBottom]
//
//        gradientLayer.locations = [1.0, 0.0]
//
//        gradientLayer.frame = self.curveView.bounds
//
//        self.curveView.layer.insertSublayer(gradientLayer, at:0)
//    }

extension LoginWithNumberController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if isKeyBoardOn == false{
            
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               
                let keyboardRectangle = keyboardFrame.cgRectValue
                
                keyboardHeight = keyboardRectangle.height

                    self.nextButton.frame.origin.y = self.nextButton.frame.origin.y - self.keyboardHeight

            }
            
             isKeyBoardOn = true
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        if isKeyBoardOn == true {
            
                self.nextButton.frame.origin.y = self.nextButton.frame.origin.y + self.keyboardHeight
            
            isKeyBoardOn = false
        }
  
        
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//
//        }
    }
}

