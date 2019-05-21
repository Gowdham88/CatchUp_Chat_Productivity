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
        
//        if let num = phoneNumText.text {
        
//            phoneNumber = "+91" + num
        
        phoneNumber = "+91" + "9597496508"

        
//        }else {
        
//            phoneNumber = "+91" + ""
        
//        }
                
        UserDefaults.standard.set(phoneNumber!, forKey: "phone")
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { (verificationID, error) in
            
            if let error = error {
                
                print("error occurred while signing in",error)
                
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

            let sb = UIStoryboard(name: "Auth", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "VerifyOTPVController")
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
      
    }
    
    
}

extension LoginWithNumberController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.nextButton.frame.origin.y = self.nextButton.frame.origin.y - 280
            
        })
        
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: .curveEaseIn, animations: {
            
            self.nextButton.frame.origin.y = self.nextButton.frame.origin.y + 280
            
        })
        
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


