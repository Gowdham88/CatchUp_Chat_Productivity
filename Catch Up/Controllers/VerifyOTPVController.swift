//
//  VerifyOTPVController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VerifyOTPVController: UIViewController {

    @IBOutlet weak var GradientAndCurveView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var enterOTPField: UITextField!
    
    @IBOutlet weak var enteredNumberField: UITextField!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var resendOTPButton: UIButton!
    
    
    var timer : Timer?
    
    // sum up the timer
    
    var totalCount = 40
    
//    var Count = 0
    
    var summedCount = ""
    
    var savedPhoneNumber: String?
    
    //get keyboard's height
    
    var keyboardHeight: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let  saved = UserDefaults.standard.object(forKey: "authVerificationID")
        
        savedPhoneNumber = UserDefaults.standard.object(forKey: "phone") as! String
        
        if let number = savedPhoneNumber {
            
            enteredNumberField.text = number
        }
        
        enteredNumberField.delegate = self
        
        roundedTop(targetView: GradientAndCurveView, desiredCurve: 1)
        
        enterOTPField.delegate = self
    
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        
        self.navigationController?.navigationBar.barStyle = .black
        
        timerLabel.textColor = UIColor.red
        
        startTimer()
    }
    
    @IBAction func didTappedResendOTP(_ sender: Any) {
        
        totalCount = 40
        
        if let phoneNumber = savedPhoneNumber {
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                
                if let error = error {
                    
                    print("error occurred while signing in",error)
                    
                    return
                }
                
                self.startTimer()
                
            }
        }
        

    }
    
    @IBAction func phoneNumberEditButton(_ sender: Any) {
        
        enteredNumberField.becomeFirstResponder()
    }
    
    @IBAction func didTappedSend(_ sender: Any) {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: enterOTPField.text!)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print("error occured while verifying OTP",error)
                
                return
            }
            
            // User is signed in
            
            print("login successfull \(authResult)")
            let sb = UIStoryboard(name: "Auth", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CreateProfileController")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
 
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

extension VerifyOTPVController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.sendButton.frame.origin.y = (self.sendButton.frame.origin.y) - 280
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.sendButton.frame.origin.y = (self.sendButton.frame.origin.y) +  280
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        enterOTPField.resignFirstResponder()
        
        enteredNumberField.resignFirstResponder()
    }
}

extension VerifyOTPVController {
    
    func startTimer () {
        
        if timer == nil {
           timer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(1.0),
                target      : self,
                selector    : #selector(self.timerAction),
                userInfo    : nil,
                repeats     : true)
        }
        
        resendOTPButton.isUserInteractionEnabled = false
        resendOTPButton.alpha = 0.3
    }
    
    func stopTimer() {
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        resendOTPButton.isUserInteractionEnabled = true
        resendOTPButton.alpha = 1.0
    }
    
   @objc func timerAction() {
    
        totalCount -= 1
    
    summedCount = String(format: "%02d", totalCount)
    
    timerLabel.text = "in" + " 0:" + summedCount
        
        if summedCount == "00" {
        
             stopTimer()
            
          }
    }
}
