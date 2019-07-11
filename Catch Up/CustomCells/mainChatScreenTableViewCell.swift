//
//  mainChatScreenTableViewCell.swift
//  Catch Up
//
//  Created by Siva on 27/06/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseStorage
import FirebaseDatabase

class mainChatScreenTableViewCell: UITableViewCell {
    
//    PaddingLabel
    @IBOutlet weak var recievedMessageLbl: UILabel!
    
    @IBOutlet weak var recievedMessageView: UIView!
    
    @IBOutlet weak var sentMessageLbl: UILabel!
    
    @IBOutlet weak var sentMessageView: UIView!
    
    @IBOutlet var receivedTimeLabel: UILabel!
    
    @IBOutlet var sentTimeLabel: UILabel!
    
    @IBOutlet var likeOrUnlikeImageView: UIImageView!
    
//    @IBOutlet var errorImageView: UIImageView!
        
    @IBOutlet var checkImage: UIImageView!
    
    var message: Message!
    
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sentMessageView.layer.masksToBounds  = true
        recievedMessageView.layer.masksToBounds = true
        
//        label.textAlignment = .center
//        label.sizeToFit()
//        label.frame = CGRect( x: label.frame.x, y: label.frame.y,width:  label.frame.width + 20,height: label.frame.height + 8)
        
//        label.frame = CGRect( x: label.frame.origin.x - 10, y: label.frame.origin.y - 4, width: label.frame.width + 20,height: label.frame.height + 8)
        
        recievedMessageLbl.textAlignment = .left
        recievedMessageLbl.sizeToFit()
        recievedMessageLbl.frame = CGRect(x: recievedMessageLbl.frame.origin.x , y: recievedMessageLbl.frame.origin.y , width: recievedMessageLbl.frame.width + 20, height: recievedMessageLbl.frame.width + 8)

        sentMessageLbl.textAlignment = .right
        sentMessageLbl.sizeToFit()
        sentMessageLbl.frame = CGRect(x: sentMessageLbl.frame.origin.x , y: sentMessageLbl.frame.origin.y , width: sentMessageLbl.frame.width + 20, height: sentMessageLbl.frame.width + 8)
//        sentMessageLbl.contentEdgeInsets =
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(message: Message) {
        
        self.message = message
        
        print("message label::\(message.message.count)")
        
        print("sender id : \(message.sender) receiver id: \(String(describing: currentUser))")

        
        print("sender id \(message.sender) and current user \(String(describing: currentUser))")
        
        if message.sender == currentUser {
            

            
            sentMessageView.isHidden = true
            sentMessageLbl.isHidden = true
            sentMessageLbl.text = ""
            
            print("receive message",message.message)
            
//            recievedMessageLbl.frame.size.width = recievedMessageLbl.intrinsicContentSize.width + 10
//            recievedMessageLbl.frame.size.height = recievedMessageLbl.intrinsicContentSize.height + 10
            
//            recievedMessageLbl.text = message.message
            
            let strValue = message.message
            recievedMessageLbl?.text = " \(" " + strValue + " " )"
            
            let timeNew1 = getReadableDate(timeStamp: message.receivedTimeStamp)
            print("new time1:::\(String(describing: timeNew1))")
            sentTimeLabel.text =  timeNew1
            recievedMessageLbl.isHidden = false
            
            recievedMessageView.layer.backgroundColor = UIColor.clear.cgColor
            
        } else {
            
 
            
            sentMessageView.isHidden = false
            
            sentMessageView.layer.backgroundColor = UIColor.clear.cgColor
//           sentMessageLbl.frame.size.width = sentMessageLbl.intrinsicContentSize.width + 10
//           sentMessageLbl.frame.size.height = sentMessageLbl.intrinsicContentSize.height + 10
            print("sent messages",message.message)
//            sentMessageLbl.text =  message.message
            
            
            
            recievedMessageLbl.text = ""
            let strValue = message.message
            sentMessageLbl?.text = "\(" " + strValue + " " )"
            
            print("timestamp:::\(message.receivedTimeStamp)")
            let timeNew1 = getReadableDate(timeStamp: message.receivedTimeStamp)
            print("new time1:::\(String(describing: timeNew1))")
 
            sentTimeLabel.text =  timeNew1

            recievedMessageLbl.isHidden = true
            
            recievedMessageView.isHidden = true

            
            
   

        }
    }
    
  
    func getReadableDate(timeStamp: TimeInterval) -> String? {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation()   // get current TimeZone abbreviation or set to GMT+5:30
        print("current time zone data:::\(String(describing: timezone))")
        dateFormatter.timeZone = TimeZone(abbreviation: timezone!) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    


}

