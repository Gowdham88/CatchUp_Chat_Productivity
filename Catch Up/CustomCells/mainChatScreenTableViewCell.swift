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
        
        print("message label::\(message.messageText.count)")
        
        print("sender id : \(message.sender) receiver id: \(String(describing: currentUser))")

        
        print("sender id \(message.sender) and current user \(String(describing: currentUser))")
        
        if message.sender == currentUser {
            

            
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
            
            print("receive message",message.messageText)
            
//            recievedMessageLbl.frame.size.width = recievedMessageLbl.intrinsicContentSize.width + 10
//            recievedMessageLbl.frame.size.height = recievedMessageLbl.intrinsicContentSize.height + 10
            
//            recievedMessageLbl.text = message.message
            
            let strValue = message.messageText
            recievedMessageLbl?.text = " \(strValue)"
            
            receivedTimeLabel.text =  dateString
            
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
//           sentMessageLbl.frame.size.width = sentMessageLbl.intrinsicContentSize.width + 10
//           sentMessageLbl.frame.size.height = sentMessageLbl.intrinsicContentSize.height + 10
            print("sent messages",message.messageText)
//            sentMessageLbl.text =  message.message
            sentTimeLabel.text =  dateString
            
            recievedMessageLbl.text = ""
            let strValue = message.messageText
            sentMessageLbl?.text = " \(strValue)"
            
            recievedMessageLbl.isHidden = true
            
            recievedMessageView.isHidden = true

            
            
   

        }
    }
    
    func getCurrentTimeZone() -> String{
        
        return TimeZone.current.identifier
        
    }
    
  

}

class PaddingLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 20, left: 28, bottom: 20, right: 20)//CGRect.inset(by:)
        super.drawText(in: rect.inset(by: insets))
    }
}
