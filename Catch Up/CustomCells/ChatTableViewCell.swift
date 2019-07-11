//
//  ChatTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var recipientImg: UIImageView!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!
    
    @IBOutlet var timeStampLabel: UILabel!
    var messageDetail: MessageDetail!
    var userPostKey: DatabaseReference!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recipientImg.layer.cornerRadius = recipientImg.frame.height/2
        recipientImg.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(messageDetail: MessageDetail){
        
        self.messageDetail = messageDetail
        
        print("printing message detail",messageDetail)
        
//        for item in messageDetail {
//
//            print("valessssssss",ite)
//        }
       
        print("messageDetail.recipient", messageDetail.recentMessage)
       
        let recipientData = Database.database().reference().child("user").child(messageDetail.recipient)
       
        recipientData.observeSingleEvent(of: .value) { (snapshot) in
            
            let data = snapshot.value as! Dictionary<String, AnyObject>
            
            print("printing whole user data",data)
            
            for item in data {
                
                if item.key == "userName" {
                    
                    self.recipientName.text = item.value as? String
                }
                
                if item.key == "userPhotoThumbnail" {
                    
//                    let urll = NSURL(string: item.value as! String)
//
//                    do {
//
//                        let dataa = try Data(contentsOf: urll as! URL)
//
//                        self.recipientImg.image = UIImage(data: dataa)
//                    }
                    
                    if let photoUrl = URL(string: item.value as! String) {
                        
                        self.recipientImg.sd_setImage(with: photoUrl)
                    }
            
                    
                }
                
                if item.key == "messages" {
                    
                    let chatMessages = item.value as? Dictionary<String, AnyObject>
                    
                    print("chat messagessss",chatMessages)
                    
                    for val in chatMessages! {
                        
                        print("key is \(val.key) and val is \(val.value)")
                        
                        if val.key == messageDetail.messageKey {
                            
                            print("recent chat is",val.value)
                            
                            for itemm in (val.value as? Dictionary<String,AnyObject>)! {
                                
                                if itemm.key == "lastmessage" {
                                    
                                    self.chatPreview.text = itemm.value as! String
                                }
                                
                                if itemm.key == "timestamp" {
                                    
                                    let newTime = self.getReadableDate(timeStamp: itemm.value as! TimeInterval)
                                    print("new time :::\(String(describing: newTime))")
                                    
                                      self.timeStampLabel.text = newTime
                                    
                                    
//                                    let addedTime = itemm.value
//                                    let timeinterval : TimeInterval = addedTime as! TimeInterval
//                                    let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
//                                    let dateFormater : DateFormatter = DateFormatter()
////                                    dateFormater.locale = Locale(identifier: "en_IN")
////                                    dateFormater.timeZone = NSTimeZone(name: "GMT+5:30") as TimeZone?
//
//                                    if Calendar.current.isDateInToday(dateFromServer as Date) {
//
//                                        dateFormater.dateFormat = "'Today' hh:mm a"
//                                    }
//                                    else if Calendar.current.isDateInYesterday(dateFromServer as Date) {
//
//                                        dateFormater.dateFormat = "'Yesterday' hh:mm a"
//                                    }
//                                    else {
//
//                                        dateFormater.dateFormat = "dd-MM-yyyy"
//                                    }
//
//
//                                   let dateValue = self.relativeDate(for: dateFromServer as Date)
//                                    print("date value::\(dateValue)")
////
//                                    let timenewValue = self.getPastTime(for:  dateFromServer as Date)
//                                    print("time new value:::\(timenewValue)")
                                    
//                                    self.timeStampLabel.text = dateFormater.string(from: dateFromServer as Date)
                                  

                                }
                            }
                            
                        
                        }
                    }
                    
                    //                    self.chatPreview.text = chatMessages.
                }
            }
            
//            let username = data["useraName"]
//
//            let userImg = data["userPhotoThumbnail"]
//
//            self.recipientName.text = username as? String
//
//            self.chatPreview.text = self.messageDetail.recipient

//            let ref = Storage.storage().reference(forURL: userImg as! String)

//            ref.getData(maxSize: 100000, completion: { (data, error) in
//
//                if error != nil {
//
//                    print("could not load image")
//                } else {
//
//                    if let imgData = data {
//                        if let img = UIImage(data: imgData) {
//
//                            self.recipientImg.image = img
//                        }
//                    }
//                }
//
//            })
            

        }
        
    }//configureCell
    
    
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
//                dateFormatter.dateFormat = "dd/MM/yyyy"
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
    
    func relativeDate(for date:Date) -> String {

        let components = Calendar.current.dateComponents([.day, .year, .month, .weekOfYear, .hour, .minute], from: date, to: Date())
        if let year = components.year, year == 1{
            return "\(year) year ago"
        }
        if let year = components.year, year > 1{
            return "\(year) years ago"
        }
        if let month = components.month, month == 1{
            return "\(month) month ago"
        }
        if let month = components.month, month > 1{
            return "\(month) months ago"
        }

        if let week = components.weekOfYear, week == 1{
            return "\(week) week ago"
        }
        if let week = components.weekOfYear, week > 1{
            return "\(week) weeks ago"
        }

        if let day = components.day{
            if day > 1{
                return "\(day) days ago"
            }else{
                "Yesterday"
            }
        }

        return "Today"
    }
    
    
    func getPastTime(for date : Date) -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, hh:mm a"
            formatter.locale = Locale(identifier: "en_IN")
            formatter.timeZone = TimeZone(identifier: "GMT+5:30")
            let strDate: String = formatter.string(from: date)
            return strDate
        }
    }
    
    

}
