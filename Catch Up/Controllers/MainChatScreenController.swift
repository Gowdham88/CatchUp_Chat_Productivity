//
//  MainChatScreenController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/16/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Photos
//import JSQMessagesViewController
//import IQAudioRecorderController
import IDMPhotoBrowser
import Firebase
import FirebaseMessaging
import FirebaseDatabase
import JSQMessagesViewController
import FirebaseStorage
import SwiftKeychainWrapper
import CoreFoundation



//import CameraManager


 var forwardMessageArray = [Message]()

class MainChatScreenController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
  
  
//    func messagesCollectionViewCellDidTapAvatar(_ cell: JSQMessagesCollectionViewCell!) {
//
//    }
//
//    func messagesCollectionViewCellDidTapMessageBubble(_ cell: JSQMessagesCollectionViewCell!) {
//
//    }
//
//    func messagesCollectionViewCellDidTap(_ cell: JSQMessagesCollectionViewCell!, atPosition position: CGPoint) {
//
//    }
//
//    func messagesCollectionViewCell(_ cell: JSQMessagesCollectionViewCell!, didPerformAction action: Selector!, withSender sender: Any!) {
//
//    }
//

//    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
//
//    }
    
  
let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var recipient: String!
    var messageId: String!
    var userContactNumber: String!
    var userContactName: String!
    var userContactImage: String!
    
//    var messages = [Message]()
    
    var messages = [Message]()
    
    var message: Message!

    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    
   // navigation outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navProfileImage: UIImageView!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var navigationView: GradientView!
    @IBOutlet weak var threadBackupView: UIView!
//    @IBOutlet weak var threadMainImageView: UIImageView!
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var navProfileName: UILabel!
    
    
    // bottom bar outlets
    
    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var attachmentButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
//    var cameraManager : CameraManager!
    
    
    @IBOutlet var recordView: UIView!
    @IBOutlet var openKeyboard: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var recordDeleteButton: UIButton!
    @IBOutlet var recordAudioButton: UIButton!
    @IBOutlet var sendRecordButton: UIButton!
  
    @IBOutlet weak var longPressView: UIView!
    
    
    
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var meterTimer:Timer!
    var isRecording = false
    var isAudioRecordingGranted: Bool!
    
   
    
//    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet var cameraOVerlayView: UIView!
    
    // listeners
    
//    var typingListener: ListenerRegistration?
//    var updatedChatListener: ListenerRegistration?
//    var newChatListener: ListenerRegistration?
    
    // initializers for chat
    
    let legitTypes = [kAUDIO, kVIDEO, kTEXT, kLOCATION, kPICTURE]
    var maxMessageNumber = 0
    var minMessageNumber = 0
    var loadOld = false
    var loadedMessagesCount = 0
    var typingCounter = 0
//    var messages: [JSQMessage] = []
    var objectMessages: [NSDictionary] = []
    var loadedMessages: [NSDictionary] = []
    var allPictureMessages: [String] = []
    var initialLoadComplete = false
    var jsqAvatarDictionary: NSMutableDictionary?
    var avatarImageDictionary: NSMutableDictionary?
    var showAvatars = true
    var firstLoad: Bool?
    var keyboardSize: CGRect?
    var openKeyboardForFirstTime: Bool = true
    
    var dummyBoolArray = [true,false,false,true,true,false,true,false]
    
    var dummyMessageArray = ["heysdhfishfisdhfisdhfosdhfpsdhfojdshfjpsdhfkjsdhfjdskhfjsdhfsdjhfskdjhfdskjhfdsjfhsdjhfdsjkhfdskjhfdskjfhdsjkhfdsjhfdskjhfdskjfhdskjhfdskjfhdkjsfhdskjhfdksj hey hey hey hey hey hey hey hey","hey hey hey hey hey hey hey hey","how are you","im fine","how is going","good","ok","take care"]
    
    var messageKeyName = [String]()
    var userMessageKeyName = [String]()

    @IBOutlet var btnRecordOrSend: UIButton!
    
    
//    var outgoingBubble = JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
//
//    var incomingBubble = JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
//
//     let composeVC = JSQMessagesViewController()
    
    var isLongPressed: Bool = false
    
    var checkImageArray = [UIImage]()
    
    @IBOutlet var bottomBarHeightConstant: NSLayoutConstraint!
    
    var messageType: String?
    
    var messageTypeArray: String?
    
    var groupMemebersArray = [String:String]()
    
    var toArray = [String:String]()
    
    var replyView: UIView!
    
     var selectedCount: Int = 0
    
     let reff = Database.database().reference()
    
    var savedAutoIDArray = [String]()
    
    var selectedMessage = ""
    var replyBool = false
    
    var toBeReplied: String?
    
    var swipedIndexPath: IndexPath?
    
    var isForwardMessage: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // read from clipboard
        let content = UIPasteboard.general.string
        
        print("clip board text \(content ?? "")")
    
        self.longPressView.isHidden = true
        recordView.isHidden = true
        
//        self.longPressView.layer.masksToBounds = false
        
//        longPressView.layer.shadowPath = UIBezierPath(rect: longPressView.bounds).cgPath
//        longPressView.layer.shadowRadius = 5
//        longPressView.layer.shadowOffset = .zero
//        longPressView.layer.shadowOpacity = 1
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 650

//        self.chatTableView.frame = CGRect(x: self.chatTableView.frame.origin.x, y: self.chatTableView.frame.origin.y, width: self.chatTableView.frame.size.width, height: self.view.frame.size.height - self.chatTableView.frame.origin.y)


        // Do any additional setup after loading the view.
        
//        print("selected recipient id ::\(recipient)")
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
      //table view background changed here..
        
//        let backgroundImage = #imageLiteral(resourceName: "image")
//        let imageView = UIImageView(image: backgroundImage)
//
//        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.chatTableView.frame.size.width, height: self.chatTableView.frame.size.height))
//
//        overlay.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//
//        imageView.addSubview(overlay)
//
//        self.chatTableView.backgroundView = imageView
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)


        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // target for group button
        
        groupButton.addTarget(self, action: #selector(groupButtonOrClose(sender:)), for: .touchUpInside)
    
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//
//        view.addGestureRecognizer(tap)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
        
            self.moveToBottom()
    
//        }
        
        typeMessageTextField.delegate = self
        
        // set corner radius for view's rounded corner
        
        threadBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
//        threadMainImageView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        chatTableView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        recordView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        bottomBarView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        longPressView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        navProfileImage.layer.cornerRadius = navProfileImage.frame.height/2
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
           
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
          
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        
        recordView.layer.masksToBounds = false
        
//        picker?.delegate = self
        
        
        // button targetss
        
        openKeyboard.addTarget(self, action: #selector(openKeyboard(sender:)), for: .touchUpInside)
        recordDeleteButton.addTarget(self, action: #selector(deleteRecord(sender:)), for: .touchUpInside)
        recordAudioButton.addTarget(self, action: #selector(audioRecord(sender:)), for: .touchUpInside)
        sendRecordButton.addTarget(self, action: #selector(sendRecord(sender:)), for: .touchUpInside)

        checkPermission()
        displayMessageInterface()
        
        // long press and select messages
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCell(gesture:)))
        chatTableView.isUserInteractionEnabled = true
        longPress.delegate = self
        chatTableView.addGestureRecognizer(longPress)
        
        // shadow for bottom view
        
//        self.bottomBarView.layer.shadowPath =
//            UIBezierPath(roundedRect: self.bottomBarView.bounds,
//                         cornerRadius: self.bottomBarView.layer.cornerRadius).cgPath
//        self.bottomBarView.layer.shadowColor = UIColor.black.cgColor
//        self.bottomBarView.layer.shadowOpacity = 0.5
//        self.bottomBarView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        self.bottomBarView.layer.shadowRadius = 1
//        self.bottomBarView.layer.masksToBounds = false
//        self.bottomBarView.clipsToBounds = true
        
//        bottomBarView.layer.cornerRadius = 20.0
//        bottomBarView.clipsToBounds = false
//        bottomBarView.layer.shadowRadius = 10.0
//        bottomBarView.layer.shadowOpacity = 0.2
//        bottomBarView.layer.shadowColor = UIColor.gray.cgColor
//        bottomBarView.layer.shadowOffset = CGSize(width: 3 , height:3)
//        bottomBarView.layer.masksToBounds = false
     
        if messageId != "" && messageId != nil {
            
            loadData()
            
        }
        
//        bottomBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    } //viewdidload
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if messageId != "" && messageId != nil {
        
            loadData()
            
        }
        
        NavProfileData()
        navProfileFromContact()
        
    }//viewdidappear
    
    
    func navProfileFromContact(){
        
        if let userImg = userContactImage {
            
            
            self.navProfileImage.sd_setImage(with: URL(string: userImg))
            
        }
        
        if let userName = userContactName {
            
            self.navProfileName.text = userName
        }
        
    }

    func NavProfileData(){
  
        
        let recipientData = Database.database().reference().child("user").child(recipient)
        
        recipientData.observeSingleEvent(of: .value) { (snapshot) in
            
            let data = snapshot.value as! Dictionary<String, AnyObject>
            
            for item in data {
                
                if item.key == "userName" {
                    
                    self.navProfileName.text = item.value as? String
                    
                }
                
                if item.key == "userPhotoThumbnail" {

                    
                    if let photoUrl = URL(string: item.value as! String) {
                                                
                        
                        self.navProfileImage.sd_setImage(with: photoUrl)
                    }
                    
                    
                }
                

            }
            
        }
        
    }
    
    
    @objc func keyboardWillShow(notify: NSNotification) {
        
        if openKeyboardForFirstTime == true {
            
            keyboardSize = (notify.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue

            openKeyboardForFirstTime = false
        }
        
            if self.view.frame.origin.y == 0 {
                
                if let Keyboard = keyboardSize  {
                    
                     self.view.frame.origin.y -= Keyboard.height
                }
               
            }
    }
    

    
    @objc func keyboardWillHide(notify: NSNotification) {
        
//        if let keyboardSize = (notify.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        
//        }
        
        if self.view.frame.origin.y != 0 {
            
            if let Keyboard = keyboardSize {
                
                self.view.frame.origin.y += Keyboard.height
            }
            
        }
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        recordView.isHidden = true
        
        typeMessageTextField.resignFirstResponder()
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        
//        self.navigationController?.popViewController(animated: true)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTappedEmoji(_ sender: Any) {
        
        
    }
    
    func displayMessageInterface() {
       
//        composeVC.automaticallyScrollsToMostRecentMessage = true
//        composeVC.collectionView.delegate = self
//        composeVC.send
        
        
//        composeVC.messageComposeDelegate = self
//
//        // Configure the fields of the interface.
//        composeVC.recipients = ["3142026521"]
//        composeVC.body = "I love Swift!"
        
        // Present the view controller modally.
//        if MFMessageComposeViewController.canSendText() {
//            self.present(composeVC, animated: true, completion: nil)
//        } else {
//            print("Can't send messages.")
//        }
    }
    
    @IBAction func didTappedAttchments(_ sender: Any) {
        
        openGallery()
        
        // for image
        
//        let myPickerController = UIImagePickerController()
        
//        myPickerController.delegate = self;
//        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
//        addChild(myPickerController)
//        threadMainImageView.addSubview(myPickerController.view)
        
//        myPickerController.view.frame = threadMainImageView.bounds
//
//        myPickerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
//        let pickerr = ImagePickerController()
//        pickerr.delegate = self
//        present(pickerr, animated: true, completion: nil)
        
        
        
//            self.present(pickerr, animated: true, completion: nil)
//
//        myPickerController.didMove(toParent: self)
    }
    
    @IBAction func didTappedCamera(_ sender: Any) {
        
//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
//
//            picker?.cameraOverlayView = cameraOVerlayView
//
//            picker?.showsCameraControls = false
        
            
//            cameraManager.addPreviewLayerToView(self.view)
//            cameraManager.shouldFlipFrontCameraImage = true
//            picker!.sourceType = UIImagePickerController.SourceType.camera
//            self .present(picker!, animated: true, completion: nil)
//        }
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "CutomCameraViewController")
        
        self.navigationController?.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func recordOrSendButton(_ sender: Any) {
        
        if btnRecordOrSend.imageView?.image == UIImage(named: "btn_send2") {
            
//            messageSend(messageType: messageType ?? "TEXT", chatAttachment: "")
            
            
            messageSendnew()
            
            recordView.isHidden = true
            
//            messageType = "TEXT"
            
        }else {
            
            messageType = "AUDIO"
            
             recordView.isHidden = false
        }
        
        
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //chat table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("returining number of messages \(messages.count)")
        
        print("forward messages \(forwardMessageArray.count)")
        
        if isForwardMessage {
            
            return forwardMessageArray.count
            
        }else {
            
            return messages.count
        }
        
        
        
//        return dummyMessageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var message : Message?
        
        if isForwardMessage {
            
            message = forwardMessageArray[indexPath.row]
            
        }else {
            
            message = messages[indexPath.row]
        }
        
        print("message id load data::\(String(describing: message?.message))")

        
//        let message = messages[indexPath.row]
        
        if let cell = chatTableView.dequeueReusableCell(withIdentifier: "Message") as? mainChatScreenTableViewCell {
            
            cell.tag = indexPath.row
            
         
            
            if isLongPressed  {
                
                cell.checkImage.alpha = 1
                
                cell.checkImage.image = checkImageArray[indexPath.row]

            }else {
                
                cell.checkImage.alpha = 0
                
                cell.contentView.alpha = 1.0
            }
            
            
//            if messageType == "REPLY" {
//
//                replyBool = true
//
//            }else {
//
//                replyBool = false
//            }
            
//            print("swipped indexpath \(swipedIndexPath?.row)")
            
            DispatchQueue.main.async {
                
//                if self.swipedIndexPath?.row == indexPath.row {
                
//                    cell.configCell(message: message!, isReplyMessage: self.replyBool, repliedMessage: self.toBeReplied ?? "empty")
                    
//                }else {
                
//                print("message type is",self.messageType)
                
                
                    cell.configCell(message: message!, isReplyMessage: false, repliedMessage: self.toBeReplied ?? "empty", messageType: self.messageType ?? "")
                
//                else {
//
//                         cell.configCell(message: message!, isReplyMessage: false, repliedMessage: self.toBeReplied ?? "empty", messageType: self.messageType ?? "TEXT")
//                }
                
           
//                }
            }

            cell.backgroundColor = .clear

            //swipe to reply
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToReply(gesture:)))
            
            swipeGesture.direction = .right
            
            cell.isUserInteractionEnabled = true
            
            cell.addGestureRecognizer(swipeGesture)
            
            return cell
            
        } else {
            
            return mainChatScreenTableViewCell()
        }
        
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = .clear

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isLongPressed {
            
            print("long pressed message detail ",messages[indexPath.row].message,messages[indexPath.row].messageKey)
            
//            let message = messages[indexPath.row]
            
//            let messageKey = Database.database().reference().child("user").child(currentUser!).child("messages").childByAutoId()
//
//            var forwardDict = Dictionary<String, AnyObject>()
//
//            forwardDict = [ "message": message.message,
//                            "lastmessage": message
//
//
//            ]
            
            
            
            forwardMessageArray.append(messages[indexPath.row])
//
            let cell = chatTableView.cellForRow(at: indexPath) as! mainChatScreenTableViewCell
//
            if cell.checkImage.image == UIImage(named: "un-check") {

//                cell.checkImage.image = UIImage(named: "check_blue")
                
//                cell.checkImage.frame = CGRect(x: 12, y: 26, width: 20, height: 20)
                
                checkImageArray[indexPath.row] = UIImage(named: "Check")!
                
                cell.contentView.alpha = 0.5
                
                selectedCount += 1

                // open pop up view
                
                print("message keys",messages[indexPath.row].messageKey)
                
                savedAutoIDArray.append(messages[indexPath.row].messageKey)
                
                selectedMessage = messages[indexPath.row].message
                

            }else {

//                cell.checkImage.image = UIImage(named: "un-check")
                
//                cell.checkImage.frame = CGRect(x: 12, y: 26, width: 20, height: 20)
                
                checkImageArray[indexPath.row] = UIImage(named: "un-check")!
                
                let messagess = messages[indexPath.row]
                
                if forwardMessageArray.count > 0 {
                    
                   let indexToRemove = forwardMessageArray.index(where: { $0.message == messagess.message })
                    
                    forwardMessageArray.remove(at: indexToRemove!)
                    
                }
                
                cell.contentView.alpha = 1.0
                
                selectedCount -= 1
            }
            
            //dont delete this comment
            
            if selectedCount > 0 {

                self.longPressView.isHidden = false

                self.bottomBarView.isHidden = true

            }else {

                self.longPressView.isHidden = true

                self.bottomBarView.isHidden = false
            }

    }
    
        
        chatTableView.reloadData()
    }
    
    
    // long press action
    
    
    @IBAction func addTaskAction(_ sender: Any) {
   
        self.longPressView.isHidden = true
    
    }
    
    @IBAction func replyAction(_ sender: Any) {
        
        self.longPressView.isHidden = true
        
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        
        self.longPressView.isHidden = true
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectContactController") as! SelectContactController
        vc.isForward = true
        messageType = "FORWARD"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func copAction(_ sender: Any) {
        
        self.longPressView.isHidden = true
        
        // write to clipboard
        UIPasteboard.general.string = selectedMessage
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        self.longPressView.isHidden = true
        
        let mainChild = "user"
        let firstParent = currentUser!
        let secondParent = "inbox"
        
        for item in savedAutoIDArray {
            
            remove(mainParent: mainChild, parentA: firstParent, parentB: secondParent, lastChild: item)
            
        }
        

    }
    
    
    func loadData() {
//        Database.database().reference().child("user").child(currentUser!).child("outbox").queryEqual(toValue: messageId).observe(.value, with: { (snapshot) in
    Database.database().reference().child("user").child(currentUser!).child("inbox").observe(.value, with: { (snapshot) in
        
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                self.messages.removeAll()
               
                self.checkImageArray.removeAll()
                
                for data in snapshot {
                    
                    if let postDict = data.value as? Dictionary<String, AnyObject> {
                        
                        let key = data.key
                        
                        let post = Message(messageKey: key, postData: postDict)
                        
                        self.messages.append(post)
                        
                        self.checkImageArray.append(UIImage(named: "un-check")!)
                    }
                }
            }
            
            self.chatTableView.reloadData()
        })
        
    }//loadData
    

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        typeMessageTextField.resignFirstResponder()//
//
//        recordView.isHidden = true
//
//        messageSend()
//        messageSendnew()
//
//        return true
//    }
    func messageSendnew(){
        
        let chatTaskArray = NSMutableArray()
        let deliveredListArray = NSMutableArray()
        let messageStatusRecipientWiseArray = NSMutableArray()
        let readListArray = NSMutableArray()
        let recipientsArray = NSMutableArray()
        let replyChatMessage = [String: AnyObject]()
        
        print("printing message id here \(messageId)")
        
        if (typeMessageTextField.text != nil && typeMessageTextField.text != "") {
            
            print("recipient id::::\(String(describing: recipient))")
            
            if messageId == nil {
                
                 messageId = Database.database().reference().child(recipient).child("inbox").childByAutoId().key
                
                let post: Dictionary<String, AnyObject> = [
                    "messageText": typeMessageTextField.text as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                    "sender": recipient as AnyObject,
                    "chatCreatedDateTime": ["timestamp":Int(NSDate().timeIntervalSince1970)] as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachment": "" as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject,
                    "chatWindowName": userContactName as AnyObject,
                    "deleted": false as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "group": false as AnyObject,
                    "groupMembers": groupMemebersArray as AnyObject,
                    "groupMemebersCount": groupMemebersArray.count as AnyObject,
                    "hightlight": 0 as AnyObject,
                    "messageChatStatus": "INPROGRESS" as AnyObject,
                    "messageOrigin": "OTHER" as AnyObject,
                    "messageText": typeMessageTextField.text as AnyObject,
                    "participantAllowedToEditGroupInfo": true as AnyObject,
                    "participantAllowedToMessage": true as AnyObject,
                    "task": false as AnyObject,
                    "to": toArray as AnyObject,
                    "uploadComplete": true as AnyObject
                ]
                
                let outbox: Dictionary<String, AnyObject> = [
                    "sender": recipient as AnyObject,
                    "addOns": "" as AnyObject,
                    "chatCreatedDateTime": ["timestamp":Int(NSDate().timeIntervalSince1970)] as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "chatAttachmentDownloadFileDir": "" as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachment": "" as AnyObject,
                    "chatAttachmentFileName": "" as AnyObject,
                    "chatAttachmentSize": "" as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageThumbnail": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject,
                    "chatWindowName": userContactName as AnyObject,
                    "chatTask": chatTaskArray as AnyObject,
                    "deliveredList": deliveredListArray as AnyObject,
                    "isDeleted": false as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "isGroup": false as AnyObject,
                    "groupDescription": "" as AnyObject,
                    "groupMembers": groupMemebersArray as AnyObject,
                    "groupMemebersCount": groupMemebersArray.count as AnyObject,
                    "hightlight": 0 as AnyObject,
                    "messageChatStatus": "INPROGRESS" as AnyObject,
                    "messageOrigin": "SELF" as AnyObject,
                    "messageText": typeMessageTextField.text as AnyObject,
                    "messageStatusRecipientWise": messageStatusRecipientWiseArray as AnyObject,
                    "participantAllowedToEditGroupInfo": true as AnyObject,
                    "participantAllowedToMessage": true as AnyObject,
                    "readList": readListArray as AnyObject,
                    "recipients" : recipientsArray as AnyObject,
                    "replyChatMessage": replyChatMessage as AnyObject,
                    "isTask": false as AnyObject,
                    "to": toArray as AnyObject,
                    "isUploadComplete": true as AnyObject
                ]
            
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                ]
                
                
                let firebase_recipient_Message = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId)
                    
                    firebase_recipient_Message.setValue(post)
                
                if currentUser != nil {
                    
                    let firebase_currentUser_Message = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId)
                    
                    firebase_currentUser_Message.setValue(outbox)
                }
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId)

                recipentMessage.setValue(recipientMessage)

                let userMessage = Database.database().reference().child("user").child(currentUser!).child("inbox").child(messageId)

                userMessage.setValue(message)
                
                loadData()
                
            } else if messageId != "" {
                
//                let post: Dictionary<String, AnyObject> = [
//
//                    "messageText": typeMessageTextField.text as AnyObject,
//                    "sender": recipient as AnyObject,
//                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
//                    "chatId" : userContactNumber as AnyObject,
//                    "from": userContactNumber as AnyObject,
//                    "chatMessageType": "TEXT" as AnyObject,
//                    "chatMessageId": messageId as AnyObject,
//                    "to": ["1", "2"] as AnyObject
//
//                ]
                
                messageId = Database.database().reference().child(recipient).child("inbox").childByAutoId().key
                
                // send attachment
                let postAttachment: Dictionary<String,AnyObject> = ["chatAttachment": "" as AnyObject,
                                                                    "chatAttachmentFileName": "" as AnyObject,
                                                                    "chatAttachmentSize": "" as AnyObject,
                                                                    "sender": recipient as AnyObject,
                                                                    "chatCreatedDateTime": ["timestamp":Int(NSDate().timeIntervalSince1970)] as AnyObject,
                                                                    "chatId" : userContactNumber as AnyObject,
                                                                    "chatMessageId": messageId as AnyObject,
                                                                    "chatAttachmentCaption": "" as AnyObject,
                                                                    "chatMessageType": messageType as AnyObject,
                                                                    "chatWindowName": userContactName as AnyObject,
                                                                    "deleted": false as AnyObject,
                                                                    "from": userContactNumber as AnyObject,
                                                                    "group": false as AnyObject,
                                                                    "groupMembers": groupMemebersArray as AnyObject,
                                                                    "groupMemebersCount": groupMemebersArray.count as AnyObject,
                                                                    "hightlight": 0 as AnyObject,
                                                                    "messageChatStatus": "INPROGRESS" as AnyObject,
                                                                    "messageOrigin": "OTHER" as AnyObject,
                                                                    "messageText": typeMessageTextField.text as AnyObject,
                                                                    "participantAllowedToEditGroupInfo": true as AnyObject,
                                                                    "participantAllowedToMessage": true as AnyObject,
                                                                    "task": false as AnyObject,
                                                                    "to": toArray as AnyObject,
                                                                    "uploadComplete": true as AnyObject]
                
                let post: Dictionary<String, AnyObject> = [
                    "sender": recipient as AnyObject,
                    "chatCreatedDateTime": ["timestamp":Int(NSDate().timeIntervalSince1970)] as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject,
                    "chatWindowName": userContactName as AnyObject,
                    "deleted": false as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "group": false as AnyObject,
                    "groupMembers": groupMemebersArray as AnyObject,
                    "groupMemebersCount": groupMemebersArray.count as AnyObject,
                    "hightlight": 0 as AnyObject,
                    "messageChatStatus": "INPROGRESS" as AnyObject,
                    "messageOrigin": "OTHER" as AnyObject,
                    "messageText": typeMessageTextField.text as AnyObject,
                    "participantAllowedToEditGroupInfo": true as AnyObject,
                    "participantAllowedToMessage": true as AnyObject,
                    "task": false as AnyObject,
                    "to": toArray as AnyObject,
                    "uploadComplete": true as AnyObject
                ]
                
                // send outbox
                let outbox: Dictionary<String, AnyObject> = [
                    "sender": recipient as AnyObject,
                    "addOns": "" as AnyObject,
                    "chatCreatedDateTime": ["timestamp":Int(NSDate().timeIntervalSince1970)] as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "chatAttachmentDownloadFileDir": "" as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachment": "" as AnyObject,
                    "chatAttachmentFileName": "" as AnyObject,
                    "chatAttachmentSize": "" as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageThumbnail": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject,
                    "chatWindowName": userContactName as AnyObject,
                    "chatTask": chatTaskArray as AnyObject,
                    "deliveredList": deliveredListArray as AnyObject,
                    "isDeleted": false as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "isGroup": false as AnyObject,
                    "groupDescription": "" as AnyObject,
                    "groupMembers": groupMemebersArray as AnyObject,
                    "groupMemebersCount": groupMemebersArray.count as AnyObject,
                    "hightlight": 0 as AnyObject,
                    "messageChatStatus": "INPROGRESS" as AnyObject,
                    "messageOrigin": "SELF" as AnyObject,
                    "messageText": typeMessageTextField.text as AnyObject,
                    "messageStatusRecipientWise": messageStatusRecipientWiseArray as AnyObject,
                    "participantAllowedToEditGroupInfo": true as AnyObject,
                    "participantAllowedToMessage": true as AnyObject,
                    "readList": readListArray as AnyObject,
                    "recipients" : recipientsArray as AnyObject,
                    "replyChatMessage": replyChatMessage as AnyObject,
                    "isTask": false as AnyObject,
                    "to": toArray as AnyObject,
                    "isUploadComplete": true as AnyObject
                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                ]
                
//                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
//                //                   let firebaseMessage = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId).childByAutoId()
//
//                firebaseMessage.setValue(post)
//
//                let recipentMessage = Database.database().reference().child("user").child(recipient).child("messages").child(messageId)
//
//                recipentMessage.setValue(recipientMessage)
//
//                let userMessage = Database.database().reference().child("user").child(currentUser!).child("messages").child(messageId)
//
//                userMessage.setValue(message)
                
                let firebase_recipient_Message = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId)
                
                if messageType == "TEXT" {
                    
                    firebase_recipient_Message.setValue(post)
                    
                }else {
                    
                    firebase_recipient_Message.setValue(postAttachment)
                }
                
                
                let firebase_currentUser_Message = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId)
                
                firebase_currentUser_Message.setValue(outbox)
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId)

                recipentMessage.setValue(recipientMessage)

                let userMessage = Database.database().reference().child("user").child(currentUser!).child("inbox").child(messageId)

                userMessage.setValue(message)
                
                
                loadData()
            }
            
            typeMessageTextField.text = ""
        }
        
        
        self.typeMessageTextField.resignFirstResponder()
        
        moveToBottom()
        
    }
        
    func messageSend(messageType:String,chatAttachment: String){
        
        if (typeMessageTextField.text != nil && typeMessageTextField.text != "") {
            
            print("printing message id here \(messageId)")
            
            if messageId == nil {
                
                let post: Dictionary<String, AnyObject> = [
                    "message": typeMessageTextField.text as AnyObject,
                    "sender": recipient as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachment": chatAttachment as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject
//                    "timestamp": ServerValue.timestamp() as AnyObject
                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    "chatAttachment": "" as AnyObject,
                    "chatAttachmentCaption": "" as AnyObject,
                    "chatMessageType": messageType as AnyObject
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                ]
                
//                messageId = Database.database().reference().child("messages").childByAutoId().key
                messageId = Database.database().reference().child("user").child(currentUser!).child("inbox").childByAutoId().key
                
//                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
                let firebaseMessage = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId).childByAutoId()
                
                firebaseMessage.setValue(post)
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId)
                
                recipentMessage.setValue(recipientMessage)
                
                let userMessage = Database.database().reference().child("user").child(currentUser!).child("inbox").child(messageId)
                
                userMessage.setValue(message)
                
                loadData()
                
            } else if messageId != "" {
                
                pushMessage(forward: isForwardMessage)
                
            }
            
            
            typeMessageTextField.text = ""
        }
        
        recordView.isHidden = true
        
        self.typeMessageTextField.resignFirstResponder()
        
//        self.chatTableView.reloadData()
      
        moveToBottom()


    }
    
    func pushMessage(forward: Bool) {
        
        
        let messageId = Database.database().reference().child("user").child(currentUser!).child("inbox").childByAutoId().key
        
        self.messageId = messageId
        
        var message = Dictionary<String, AnyObject>()
        
        var post = Dictionary<String, AnyObject>()
        
        var recipientMessage =  Dictionary<String, AnyObject>()

        
        if forward {
            
            post = [
                "message": forwardMessageArray.last?.message as AnyObject,
                "sender": recipient as AnyObject,
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                
            ]
            
            message = [
                "lastmessage": forwardMessageArray.last?.message as AnyObject,
                "recipient": recipient as AnyObject,
                //                    "timestamp": ServerValue.timestamp() as AnyObject
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                "chatMessageId": messageId as AnyObject,
                "chatAttachment": "" as AnyObject,
                "chatAttachmentCaption": "" as AnyObject,
                "chatMessageType": messageType as AnyObject
            ]
            
            recipientMessage = [
                "lastmessage": forwardMessageArray.last?.message as AnyObject,
                "recipient": currentUser as AnyObject,
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
            ]
            
        }else {
            
            post = [
                "message": typeMessageTextField.text as AnyObject,
                "sender": recipient as AnyObject,
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                
            ]
            
            message = [
                "lastmessage": typeMessageTextField.text as AnyObject,
                "recipient": recipient as AnyObject,
                //                    "timestamp": ServerValue.timestamp() as AnyObject
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject,
                "chatMessageId": messageId as AnyObject,
                "chatAttachment": "" as AnyObject,
                "chatAttachmentCaption": "" as AnyObject,
                "chatMessageType": messageType as AnyObject
            ]
            
            recipientMessage = [
                "lastmessage": typeMessageTextField.text as AnyObject,
                "recipient": currentUser as AnyObject,
                "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
            ]
        }
        

        
        //                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
        let firebaseMessage = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId!).childByAutoId()
        
        
        firebaseMessage.setValue(post)
        
        let recipentMessage = Database.database().reference().child("user").child(recipient).child("inbox").child(messageId!)
        
        recipentMessage.setValue(recipientMessage)
        
        let userMessage = Database.database().reference().child("user").child(currentUser!).child("inbox").child(messageId!)
        
        userMessage.setValue(message)
        
        loadData()

    }
    
    func moveToBottom() {
        
        DispatchQueue.main.async {
        
            if self.messages.count > 0  {

                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)

                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)

            }
        }
    }
    
    
    
    @IBAction func didEditingChanged(_ sender: Any) {
        
        if typeMessageTextField.text!.count >= 1 {
            
            btnRecordOrSend.setImage(UIImage(named: "btn_send2"), for: .normal)
            
        }else {
            
            btnRecordOrSend.setImage(UIImage(named: "btn voice"), for: .normal)
        }
        
    }

    
    func randomStringWithLength(len: Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 1...len {
          
            let length = UInt32 (letters.length)
           
            let rand = arc4random_uniform(length)
           
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }

   
    
}//class

extension MainChatScreenController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        messageType = "IMAGE"
        
    }

}

extension MainChatScreenController: AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    
    func checkPermission() {
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSession.RecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
        
    }
    
    @objc func deleteRecord(sender: UIButton) {
        
        if audioRecorder != nil {
            
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            
        }
        
        isRecording = false
        timerLabel.text = "00:00"
        
    }
    
    @objc func audioRecord(sender: UIButton) {
        
        if recordAudioButton.imageView?.image == UIImage(named: "Record") {
            
            
//            if(isRecording) {
//
//                finishAudioRecording(success: true)
//                recordAudioButton.setImage(UIImage(named: "Record"), for: .normal)
//                //            play_btn_ref.isEnabled = true
//                isRecording = false
//
//            }else {
//                setup_recorder()
//                isRecording = true
//                audioRecorder.record()
//                meterTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
//                recordAudioButton.setImage(UIImage(named: "stop_Record"), for: .normal)
//                //            play_btn_ref.isEnabled = false
//
//            }
            
            
            
          
                setup_recorder()
                isRecording = true
                audioRecorder.record()
                meterTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                recordAudioButton.setImage(UIImage(named: "stop_Record"), for: .normal)
                //            play_btn_ref.isEnabled = false
                
          

        }else if recordAudioButton.imageView?.image == UIImage(named: "stop_Record") {
            
            if(isRecording) {
                
                finishAudioRecording(success: true)
                recordAudioButton.setImage(UIImage(named: "send_recorded"), for: .normal)
                //            play_btn_ref.isEnabled = true
                isRecording = false
                
            }
            
        }else {
            
            var error : NSError?
            
            do {
                
                let recordedUrl = audioRecorder.url
               
                audioPlayer = try AVAudioPlayer(contentsOf: recordedUrl)
//                audioPlayer = player
                
            } catch {
                
                print("player setup error",error)
            }
            
            audioPlayer?.delegate = self

            if let err = error {
                
                print("audioPlayer error: \(err.localizedDescription)")
                
            }else{
                audioPlayer?.play()
            }
        }
        
    }
    
    @objc func sendRecord(sender: UIButton) {
        
//        messageSend(messageType: "AUDIO", chatAttachment: "")
        
    }
    
    @objc func openKeyboard(sender: UIButton) {
        
        recordView.isHidden = true
        typeMessageTextField.becomeFirstResponder()
        
    }
    
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording {
//            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d",min,sec)
            print("audio timer",totalTimeString)
            timerLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool)
    {
        if success {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        }
        else{
            print("error while finishing audio record")
        }
    }
    
    func setup_recorder() {
        if isAudioRecordingGranted {
          
            
//            let session = AVAudioSession.sharedInstance()
//            do {
////                try session.setCategory(AVAudioSession.Category.playAndRecord, with: .mixWithOthers)
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: AVAudioSession.CategoryOptions.mixWithOthers)
//                try session.setActive(true)
//                let settings = [
//                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                    AVSampleRateKey: 44100,
//                    AVNumberOfChannelsKey: 2,
//                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
//                ]
//                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
//                audioRecorder.delegate = self
//                audioRecorder.isMeteringEnabled = true
//                audioRecorder.prepareToRecord()
//            }
//            catch let error {
//                print("catched some error during recording",error)
//            }
            
            
            //Setting for recorder
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let docDir = dirPath[0]
            let soundFilePath = docDir.appending("sound.caf")
            let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
            print(soundFileURL)
            
            
            let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
                                  AVEncoderBitRateKey: 16,
                                  AVNumberOfChannelsKey : 2,
                                  AVSampleRateKey: 44100.0] as [String : Any]
            var error : NSError?
            let audioSession = AVAudioSession.sharedInstance()
     // temp comment
//            do {
//               try audioSession.setCategory(.playAndRecord)
//                //            audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
//                if let err = error{
//                    print("audioSession error: \(err.localizedDescription)")
//                }
//                audioRecorder = try AVAudioRecorder(url: soundFileURL as URL, settings: recordSettings )
//                audioRecorder.delegate = self
//                audioRecorder.isMeteringEnabled = true
//                if let err = error{
//                    print("audioSession error: \(err.localizedDescription)")
//                }else{
//                    audioRecorder?.prepareToRecord()
//                }
//            }catch{
//
//                print("catched some error during recording",error)
//            }
           
            
            
        }else {
            print("please enable audio access for catch app")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishAudioRecording(success: false)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
}

extension MainChatScreenController {
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        
//        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let docDir = dirPath[0]
//        let soundFilePath = (docDir as NSString).appendingPathComponent("sound.caf")
//        let soundFileURL = URL(fileURLWithPath: soundFilePath)
//        print("document url",soundFilePath)
//        return soundFileURL
    }
    
    func getFileUrl() -> URL {
        let randomID = UUID().uuidString
        let filename = randomID + ".m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
}

//extension MainChatScreenController: ImagePickerControllerDelegate {
//    
//    func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool {
//        return true
//    }
//    
//    func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset]) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: ImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}

//extension MainChatScreenController : UITableViewDataSource,UITableViewDelegate {
//
//
//
//}

extension MainChatScreenController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        typeMessageTextField.becomeFirstResponder()
            
        btnRecordOrSend.setImage(UIImage(named: "btn_send2"), for: .normal)
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         typeMessageTextField.resignFirstResponder()
        
        if typeMessageTextField.text!.count > 0 {
            
            recordView.isHidden = true
            
            messageType = "TEXT"
            
            btnRecordOrSend.setImage(UIImage(named: "btn_send2"), for: .normal)
            
            
        }else {
            
            recordView.isHidden = false
            
            messageType = "AUDIO"
            
            btnRecordOrSend.setImage(UIImage(named: "btn voice"), for: .normal)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        typeMessageTextField.resignFirstResponder()//
        
        recordView.isHidden = true
        
//        messageSend(messageType: messageType ?? "TEXT", chatAttachment: "")
        
        messageSendnew()

        return true
    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        print("text field count \(textField.text?.count)")
//
//
//
//        return true
//    }
  
    
    
}

// tableview cell long press gesture

extension MainChatScreenController: UIGestureRecognizerDelegate {
    
    @objc func longPressCell(gesture: UILongPressGestureRecognizer) {
        
         isLongPressed = true
        
//        let touchPoint = gesture.location(in: chatTableView)
//
//        let indexpath = chatTableView.indexPathForRow(at: touchPoint)
//
//        let cell = chatTableView.cellForRow(at: indexpath!) as! mainChatScreenTableViewCell
//
//        if gesture.state == .began {
//
//
//        }

//        if gesture.state == .ended {
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
//
//                cell.recievedMessageView.frame.origin.x = cell.checkImage.frame.origin.x + cell.checkImage.frame.width + 25
//
//            })
//
//            cell.isUserInteractionEnabled = true
//
//
//        }

        
        self.groupButton.setImage(UIImage(named: "Cross_close"), for: .normal)
        
        chatTableView.reloadData()
        
    }
    
    @objc func swipeToReply(gesture: UISwipeGestureRecognizer) {
        
        swipeToReply(gesture: gesture)
    }
    
    func swipeAndReply(gesture: UISwipeGestureRecognizer) {
        
        messageType = "REPLY"
        
        replyBool   = true
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            //            self.bottomBarView.frame.origin.y = self.bottomBarView.frame.origin.y - (120 - self.bottomBarHeightConstant.constant)
            //
            //            self.bottomBarHeightConstant.constant = 120
            //
            //            self.bottomBarView.frame.size.height = 120
            
            // alternate method
            
            //            self.bottomBarView.layer.cornerRadius = 1
            
            let touchPoint = gesture.location(in: self.chatTableView)
            
            self.swipedIndexPath = self.chatTableView.indexPathForRow(at: touchPoint)
            
            let cell = self.chatTableView.cellForRow(at: self.swipedIndexPath!) as! mainChatScreenTableViewCell
            
            //            print("cell text",self.messages[(indexpath?.row)!].message)
            
            self.bottomBarView.roundCorners(corners: [], radius: 1.0)
            
            self.bottomBarView.clipsToBounds = true
            
            let viewHeight = 80
            
            self.replyView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: Int(self.bottomBarView.frame.minY) - Int(self.bottomBarView.frame.size.height - 10)), size: CGSize(width: Int(self.bottomBarView.frame.width), height: viewHeight)))
            
            let replySubView = UIView(frame: CGRect(x: 10, y: 10, width: self.replyView.frame.width - (20), height: 60))
            
            self.replyView.backgroundColor = .white
            
            replySubView.backgroundColor = UIColor(hex: "EAF4FF")
            
            
            
            self.replyView.addSubview(replySubView)
            
            // rounded corners
            
            self.replyView.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)
            
            replySubView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 5.0)
            
            let nameLabel = UILabel(frame: CGRect(x: 7, y: 7, width: 225, height: 22))
            
            nameLabel.textColor = UIColor(hex: "1183FF")
            
            if self.messages[(self.swipedIndexPath?.row)!].sender == self.messages[(self.swipedIndexPath?.row)!].currentUser {
                
                nameLabel.text = chatUserName
                
            }else {
                
                nameLabel.text = "You"
                
            }
            
            nameLabel.font = UIFont(name: "Muli-Bold", size: 15.0)
            
            replySubView.addSubview(nameLabel)
            
            let messageLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.maxY + 5, width: 225, height: 22))
            
            messageLabel.textColor = UIColor(hex: "5B799C")
            
            messageLabel.text = self.messages[(self.swipedIndexPath?.row)!].message
            
            self.toBeReplied = self.messages[(self.swipedIndexPath?.row)!].message
            
            messageLabel.font = UIFont(name: "Muli-Regular", size: 14.0)
            
            replySubView.addSubview(messageLabel)
            
            
            // close view
            
            print("getting frame of the reply view \(replySubView.frame.maxX)")
            
            let closeButton = UIButton(frame: CGRect(x: replySubView.frame.maxX - 40, y: 12, width: 20, height: 20))
            
            closeButton.setImage(UIImage(named: "x"), for: .normal)
            
            closeButton.backgroundColor = .clear
            
            replySubView.addSubview(closeButton)
            
            
            closeButton.addTarget(self, action: #selector(self.replyCloseButton(sender:)), for: .touchUpInside)
            
            
            self.view.addSubview(self.replyView)
            
            
        })
    }
    
    @objc func replyCloseButton(sender: UIButton) {
        
        messageType = "TEXT"
        
        self.replyView.isHidden = true
        
    }
}


// group button action

extension MainChatScreenController {
    
    @objc func groupButtonOrClose(sender: UIButton) {
        
        isLongPressed = false
        
        if groupButton.imageView?.image == UIImage(named: "Cross_close") {
            
            groupButton.setImage(UIImage(named: "Group"), for: .normal)
            
            forwardMessageArray.removeAll()
            
            chatTableView.reloadData()
            
        }else {
            
            groupButton.setImage(UIImage(named: "Cross_close"), for: .normal)
            
        }
    
    }
}

extension MainChatScreenController {
    
    func remove(mainParent: String,parentA: String,parentB: String,lastChild:String) {
    
        self.reff.child(mainParent).child(parentA).child(parentB).child(lastChild)
        
        reff.removeValue { error, _ in
            
            print("error occured while removing data \(error)")
        }
    }
    // long press view button actions
    
    
}


