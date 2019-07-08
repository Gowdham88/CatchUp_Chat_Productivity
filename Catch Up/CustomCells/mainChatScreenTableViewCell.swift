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
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(message: Message) {
        
        self.message = message
        
        print("message label::\(message.message.count)")
        
        print("sender id : \(message.sender) receiver id: \(currentUser)")
//
//        if message.sender == currentUser {
//
//            sentMessageView.isHidden = true
//
//            recievedMessageView.isHidden = false
//
//            sentMessageLbl.text = "   " + message.message
//
//            recievedMessageLbl.isHidden = false
//
//            sentMessageLbl.isHidden = true
//
//        } else {
//
//            sentMessageView.isHidden = true
//
//            recievedMessageView.isHidden = false
//
//            recievedMessageLbl.text = "   " + message.message
//
//            recievedMessageLbl.isHidden = false
//
//            sentMessageLbl.isHidden = true
//
//        }
        
        print("sender id \(message.sender) and current user \(currentUser)")
        
        if message.sender == currentUser {
            
//            let time = message.receivedTimeStamp
//            let timeinterval : TimeInterval = time
//            let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
//            let formatter = DateFormatter()
//            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601) as Calendar?
//            formatter.locale = NSLocale(localeIdentifier: "en_IN") as Locale
//            //            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
//            formatter.timeZone = NSTimeZone(name: "GMT+5:30") as TimeZone?
//
//            formatter.dateFormat = "h:mm a"
//            formatter.amSymbol = "AM"
//            formatter.pmSymbol = "PM"
//            //            let dateString = formatter.stringFromDate(modfl.courseDate)
//            let dateString: String = formatter.string(from: dateFromServer as Date)
//
//            print("dateString:::\(dateString)")
//
//            sentMessageView.isHidden = false
//
//            sentMessageView.layer.backgroundColor = UIColor.clear.cgColor
//
//            print("sent messages",message.message)
//
//            sentMessageLbl.text = " " + message.message
//            sentTimeLabel.text = " " + dateString
//
//            recievedMessageLbl.text = ""
//
//            recievedMessageLbl.isHidden = true
//
//            recievedMessageView.isHidden = true
            
            
            let time = message.receivedTimeStamp
            let timeinterval : TimeInterval = time
            let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
            let formatter = DateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601) as Calendar?
            formatter.locale = NSLocale(localeIdentifier: "en_IN") as Locale
            //            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
            formatter.timeZone = NSTimeZone(name: "GMT+5:30") as TimeZone?
            
            formatter.dateFormat = "h:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            //            let dateString = formatter.stringFromDate(modfl.courseDate)
            let dateString: String = formatter.string(from: dateFromServer as Date)
            
            print("dateString:::\(dateString)")
            
            sentMessageView.isHidden = true
            sentMessageLbl.isHidden = true
            sentMessageLbl.text = ""
            
            print("receive message",message.message)
            
            recievedMessageLbl.text = " " + message.message
            
            
            
            //            if time != "" {
            //
            //
            //
            //            }
            
            receivedTimeLabel.text = " " + dateString
            
            recievedMessageLbl.isHidden = false
            
            recievedMessageView.layer.backgroundColor = UIColor.clear.cgColor
            
        } else {
            
            
            let time = message.receivedTimeStamp
            let timeinterval : TimeInterval = time
            let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
            let formatter = DateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601) as Calendar?
            formatter.locale = NSLocale(localeIdentifier: "en_IN") as Locale
            //            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
            formatter.timeZone = NSTimeZone(name: "GMT+5:30") as TimeZone?
            
            formatter.dateFormat = "h:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            //            let dateString = formatter.stringFromDate(modfl.courseDate)
            let dateString: String = formatter.string(from: dateFromServer as Date)
            
            print("dateString:::\(dateString)")
            
            sentMessageView.isHidden = false
            
            sentMessageView.layer.backgroundColor = UIColor.clear.cgColor
            
            print("sent messages",message.message)
            
            sentMessageLbl.text = " " + message.message
            sentTimeLabel.text = " " + dateString
            
            recievedMessageLbl.text = ""
            
            recievedMessageLbl.isHidden = true
            
            recievedMessageView.isHidden = true

            
            
            
            
            
            
            
        
            
//            let time = message.receivedTimeStamp
//            let timeinterval : TimeInterval = time
//            let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
//            let formatter = DateFormatter()
//            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601) as Calendar?
//            formatter.locale = NSLocale(localeIdentifier: "en_IN") as Locale
////            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
//            formatter.timeZone = NSTimeZone(name: "GMT+5:30") as TimeZone?
//
//            formatter.dateFormat = "h:mm a"
//            formatter.amSymbol = "AM"
//            formatter.pmSymbol = "PM"
////            let dateString = formatter.stringFromDate(modfl.courseDate)
//            let dateString: String = formatter.string(from: dateFromServer as Date)
//
//            print("dateString:::\(dateString)")
//
//            sentMessageView.isHidden = true
//            sentMessageLbl.isHidden = true
//            sentMessageLbl.text = ""
//
//            print("receive message",message.message)
//
//            recievedMessageLbl.text = " " + message.message
//
//
//
////            if time != "" {
////
////
////
////            }
//
//            receivedTimeLabel.text = " " + dateString
//
//            recievedMessageLbl.isHidden = false
//
//            recievedMessageView.layer.backgroundColor = UIColor.clear.cgColor

        }
    }
    
    func getCurrentTimeZone() -> String{
        
        return TimeZone.current.identifier
        
    }
    
   

}
