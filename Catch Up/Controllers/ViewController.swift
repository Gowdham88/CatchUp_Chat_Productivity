//
//  ViewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       setGradientBackground()
    }

    func setGradientBackground() {
      
        let colorTop =  UIColor(hex: "5FABFF").cgColor
       
        let colorBottom = UIColor(hex: "007AFF").cgColor
        
        let gradientLayer = CAGradientLayer()
       
        gradientLayer.colors = [colorTop, colorBottom]
       
        gradientLayer.locations = [0.0, 1.0]
       
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    
    
}

