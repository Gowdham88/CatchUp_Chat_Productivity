//
//  ProcessViewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/7/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class ProcessViewController: UIViewController {
    
    @IBOutlet weak var topBar: GradientView!
    
    @IBOutlet weak var curvedBackupView: UIView!
    
    
    var botMessageArray = ["You created a new task","Target date is changed to Mar 10 by you","Target date is changed to Mar 17 by you","You assigned a task to shravan","You changed the target date to Mar 25","Target date is changed to Apr 02"]
    
    var dateArray = ["25 Feb 2019","03 Mar 2019","10 Mar 2019","17 Mar 2019","02 Apr 2019","03 Mar 2019"]
    
    var timeArray = ["05:40 PM","05:45 PM","05:50 PM","06:40 PM","07:40 PM","09:50 PM"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        curvedBackupView.roundCorners(corners: [.topLeft,.topRight], radius: 17.0)
        
        var yPosition = 100
        
        var isFirstTime = true
        
        let imageLine = UIImageView(frame: CGRect(x: 35, y: 105, width: 2, height: 1500))
        
        imageLine.image = UIImage(named: "VerticalLine")
        
        curvedBackupView.addSubview(imageLine)
        
        imageLine.autoresizingMask = [.flexibleLeftMargin,.flexibleBottomMargin,.flexibleHeight,.flexibleWidth]
        
        for item in botMessageArray {
            
            if isFirstTime == true {
                
                let customView = UIView(frame: CGRect(x: 24, y: yPosition + 2, width: 25, height: 25))
                customView.backgroundColor = UIColor(hex: "3495FF")
                let runImage = UIImageView(frame: CGRect(x: 5, y: 5, width: 15, height: 15))
                runImage.image = UIImage(named: "taskrun")
                customView.addSubview(runImage)
                curvedBackupView.addSubview(customView)
                
                customView.layer.cornerRadius = customView.frame.height/2
                customView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin]
                
            }else {
                
                let customView = UIView(frame: CGRect(x: 30, y: yPosition + 8, width: 12, height: 12))
                customView.backgroundColor = UIColor(hex: "3495FF")
                curvedBackupView.addSubview(customView)
                
                customView.layer.cornerRadius = customView.frame.height/2
                customView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin]

            }
            
            let botLabel = UILabel(frame: CGRect(x: 70, y: yPosition, width: 350, height: 25))
            let dateLabel = UILabel(frame: CGRect(x: 70, y: Int(botLabel.frame.maxY) + 4, width: 80, height: 20))
            let timeLabel = UILabel(frame: CGRect(x: Int(dateLabel.frame.origin.x) + Int(dateLabel.frame.width) + 7, y: Int(botLabel.frame.maxY) + 4, width: 80, height: 20))
            
//            botLabel.backgroundColor = .red
//            dateLabel.backgroundColor = .blue
            
            botLabel.text = item
            dateLabel.text = "14 Mar 2019"
            timeLabel.text = "05:40PM"
            
            botLabel.textColor = UIColor(hex: "253E5B")
            dateLabel.textColor = UIColor(hex: "5B799C")
            timeLabel.textColor = UIColor(hex: "5B799C")

            
            botLabel.font = UIFont(name: "Muli-Regular", size: 16.0)
            dateLabel.font = UIFont(name: "Muli-Regular", size: 12.0)
            timeLabel.font = UIFont(name: "Muli-Regular", size: 12.0)

//            botLabel.numberOfLines = 2
//
//            dateLabel.numberOfLines = 1
            
//            botLabel.sizeThatFits(CGSize(width: 150, height: 25))
            
            curvedBackupView.addSubview(botLabel)
            curvedBackupView.addSubview(dateLabel)
            curvedBackupView.addSubview(timeLabel)
            
            yPosition += 70
            isFirstTime = false
            
            // auto resizing
            
            botLabel.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin]
            dateLabel.autoresizingMask = [.flexibleTopMargin,.flexibleWidth,.flexibleHeight,.flexibleBottomMargin]
            timeLabel.autoresizingMask = [.flexibleTopMargin,.flexibleWidth,.flexibleHeight,.flexibleBottomMargin]
            
        }
        
        print("the final y pos \(yPosition)")
        
       
    }
    


}
