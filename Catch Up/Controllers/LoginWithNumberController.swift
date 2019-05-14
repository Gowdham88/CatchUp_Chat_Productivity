//
//  LoginWithNumberController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class LoginWithNumberController: UIViewController {

    
    @IBOutlet weak var curveView: GradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let colorTop =  UIColor(hex: "5FABFF")
        
        let colorBottom = UIColor(hex: "007AFF")
        
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

extension UIView {
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
}
