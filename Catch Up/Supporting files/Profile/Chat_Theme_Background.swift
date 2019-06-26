//
//  File.swift
//  Catch Up
//
//  Created by CZSM4 on 08/06/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import UIKit

//var Themeused = [false, true, false, false, false, false]

class Chat_Background {
    
    var previousIndex: NSIndexPath!
    
    func choosecameraImage(BackView: UIView) {
        
        let firstFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let firstView = UIView(frame: firstFrame)
        
        BackView.addSubview(firstView)
        
        let secondFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let secondView = UILabel(frame: secondFrame)
        
        secondView.backgroundColor = .white
        
        let layer0 = CAGradientLayer()
        
        layer0.colors = [
            
            UIColor(red: 0.48, green: 0.67, blue: 0.87, alpha: 1).cgColor,
            
            UIColor(red: 0.61, green: 0.79, blue: 1, alpha: 1).cgColor
            
        ]
        
        layer0.locations = [0, 1]
        
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.57, b: -0.9, c: 0.9, d: 0.57, tx: -0.21, ty: 0.66))
        
        layer0.bounds = secondView.bounds.insetBy(dx: -0.5*secondView.bounds.size.width, dy: -0.5*secondView.bounds.size.height)
        
        layer0.position = secondView.center
        secondView.layer.addSublayer(layer0)
        secondView.layer.cornerRadius = 32
        
        let cameraimage = UIImage(named: "camera")
        let ImageView = UIImageView(image: cameraimage)
        ImageView.frame = CGRect(x: 18.5, y: 18.5, width: 23, height: 23)

        firstView.addSubview(secondView)
        firstView.addSubview(ImageView)
        
        firstView.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
        
    }
    
     let ThemeBackground = [UIImage(named: "Theme1"), UIImage(named: "Theme2"), UIImage(named: "Theme3"), UIImage(named: "Theme4"), UIImage(named: "Theme4")]
    let firstFrame = CGRect(x: 0, y: 0, width: 60, height: 60)

 var checkImageArray = [UIImageView]()
    
    func chooseThemes(BackView: UIView, Row: Int,selectTheme: Bool) {
        
        if selectTheme == false {
            
                let firstView = UIView(frame: firstFrame)
                
                BackView.addSubview(firstView)
                
                let cameraimage = ThemeBackground[Row - 1]
                
                let ImageView = UIImageView(image: cameraimage)
                
                ImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                
                firstView.addSubview(ImageView)
                
                firstView.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 5)
                
                let checkImage = UIImage(named: "ChatThemeCheck")
                
                let CheckImageView = UIImageView(image: checkImage)
                
                CheckImageView.frame = CGRect(x: 20, y: 17, width: 25, height: 25)
                
                ImageView.addSubview(CheckImageView)
                
                checkImageArray.append(CheckImageView)
                
                CheckImageView.isHidden = true
            
            CheckImageView.isUserInteractionEnabled = true
            
    
            
        } else {
            

           print("images in array",checkImageArray,checkImageArray.count)
//
            if let indexx = previousIndex {

                  print("printing previous index",indexx.row)

                 checkImageArray[indexx.row].isHidden = true
                
                checkImageArray[indexx.row].isUserInteractionEnabled = true

            }else {
                
                checkImageArray[Row - 1].isHidden = false
            }
            
            checkImageArray[Row - 1].isHidden = false
            
            checkImageArray[Row - 1].isUserInteractionEnabled = true
//
            previousIndex = NSIndexPath(row: Row - 1, section: 0)
            
            
            
            
        }
        
        
//        let checkImage = UIImage(named: "ChatThemeCheck")
//
//        let CheckImageView = UIImageView(image: checkImage)
//
//        CheckImageView.frame = CGRect(x: 20, y: 17, width: 25, height: 25)
        
//        BackView.backgroundColor = .red
//
//        firstView.backgroundColor = .green
//
//        ImageView.backgroundColor = .blue
        
        
//        if Themeused[Row-1] == true {
//
////            CheckImageView.alpha = 1
//
//
//        } else {
//
////            CheckImageView.alpha = 0
//
//            CheckImageView.removeFromSuperview()
//        }
        
//
        

      
        
//        firstView.addSubview(CheckImageView)
        
        
//        firstView.addSubview(secondView)
       
        
       
        
    }

    
    
}
