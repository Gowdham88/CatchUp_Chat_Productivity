//
//  CurveView.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import UIKit


class CurveView: UIView {
    
    var once = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if once {
            
            let bb = UIBezierPath()
            
            bb.move(to: CGPoint(x: 0, y: self.frame.height))
            
            // the offset here is 40 you can play with it to increase / decrease the curve height
            
            bb.addQuadCurve(to: CGPoint(x: self.frame.width, y: self.frame.height), controlPoint: CGPoint(x: self.frame.width / 2 , y: self.frame.height + 40 ))
            
            bb.close()
            
            let l = CAShapeLayer()
            
            l.path = bb.cgPath
            
            l.fillColor =  self.backgroundColor!.cgColor
            
            self.layer.insertSublayer(l,at:0)
            
            once = false
        }
        
    }
    
    
}
