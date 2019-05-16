//
//  VerifyOTPVController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class VerifyOTPVController: UIViewController {

    @IBOutlet weak var GradientAndCurveView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var enterOTPField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundedTop(targetView: GradientAndCurveView, desiredCurve: 1)
        
        enterOTPField.delegate = self
    
    }
    
    @IBAction func didTappedSend(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreateProfileController")
        self.navigationController?.pushViewController(vc, animated: true)
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
            
            self.sendButton.frame.origin.y = self.sendButton.frame.origin.y - 280
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.sendButton.frame.origin.y = self.sendButton.frame.origin.y + 280
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        enterOTPField.resignFirstResponder()
    }
}
