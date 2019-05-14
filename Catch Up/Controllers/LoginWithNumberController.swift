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
        
//        let colorTop =  UIColor(hex: "5FABFF")
//
//        let colorBottom = UIColor(hex: "007AFF")
        
//        setGradientBackground(colorTop: colorTop, colorBottom: colorBottom)
        
        roundedTop(targetView: curveView, desiredCurve: 1)


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
        
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "VerifyOTPVController")
        self.navigationController?.pushViewController(vc, animated: true)
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


