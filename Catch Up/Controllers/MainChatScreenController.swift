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
import JSQMessagesViewController
import IQAudioRecorderController
import IDMPhotoBrowser
import Firebase
import FirebaseMessaging
import FirebaseDatabase
import JSQMessagesViewController
import FirebaseStorage
import SwiftKeychainWrapper



//import CameraManager




class MainChatScreenController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,IQAudioRecorderViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
  
  
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

    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        
    }
    
  
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
    
    var isSelected: Bool = false
    
    @IBOutlet var bottomBarHeightConstant: NSLayoutConstraint!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.longPressView.isHidden = true
        recordView.isHidden = true

//        self.chatTableView.frame = CGRect(x: self.chatTableView.frame.origin.x, y: self.chatTableView.frame.origin.y, width: self.chatTableView.frame.size.width, height: self.view.frame.size.height - self.chatTableView.frame.origin.y)


        // Do any additional setup after loading the view.
        
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
        
//        chatTableView.rowHeight = UITableView.automaticDimension
        
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
        bottomBarView.layer.masksToBounds = false
     
        loadData()

        
        bottomBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    } //viewdidload
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if messageId != "" && messageId != nil {
        
            loadData()
            
        }
        
        NavProfileData()
        navProfileFromContact()
    }//viewdidappear
    
    
    func navProfileFromContact(){
        
        print("userContactName::\(String(describing: userContactName))")
        print("userContactImage::\(String(describing: userContactImage))")
        

        if let userImg = userContactImage {
            
            
            self.navProfileImage.sd_setImage(with: URL(string: userImg))
            
        }
        
        if let userName = userContactName {
            
            self.navProfileName.text = userName
        }
        
    }

    func NavProfileData(){
        
        print("chatUserImg::\(String(describing: chatUserImg))")
        print("chatUserName::\(String(describing: chatUserName))")

        
        
        
        if let userImg = chatUserImg {
            

            self.navProfileImage.sd_setImage(with: URL(string: userImg))
            
        }
        
        if let userName = chatUserName {
            
            self.navProfileName.text = userName
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
        
        self.navigationController?.popViewController(animated: true)
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
            
             messageSend()
            
            recordView.isHidden = true
            
        }else {
            
             recordView.isHidden = false
        }
        
        
    }
    
    func openGallery()
    {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            return messages.count
        
//        return dummyMessageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("message count::\(messages.count)")
        
        let message = messages[indexPath.row]
        
        print("message timestamp::\(messages[indexPath.row].receivedTimeStamp)")
        
        if let cell = chatTableView.dequeueReusableCell(withIdentifier: "Message") as? mainChatScreenTableViewCell {
            
            cell.tag = indexPath.row
            
            cell.sentMessageLbl.roundCorners(corners: [.topLeft,.bottomLeft,.bottomRight], radius: 5.0)
            
            cell.recievedMessageLbl.roundCorners(corners: [.topRight,.bottomLeft,.bottomRight], radius: 5.0)
            
            if isLongPressed  {
                
                cell.checkImage.alpha = 1
                
                cell.checkImage.image = checkImageArray[indexPath.row]
                
                if isSelected {
                    
                    cell.recievedMessageView.alpha = 0.5

                    
//                    if cell.checkImage.image == UIImage(named: "un-check") {
//
////                        cell.checkImage.image = UIImage(named: "check_blue")
//
//                        cell.checkImage.image = checkImageArray[indexPath.row]
//
//                    }else {
//
////                        cell.checkImage.image = UIImage(named: "un-check")
//                    }
 
                }else {
                    
                    cell.recievedMessageView.alpha = 1.0
                }
                

            }else {
                
                cell.checkImage.alpha = 0
            }
            
            
//            cell.checkImage.image = checkImageArray[indexPath.row]
//
//            cell.checkImage.isHidden = true
            
//            cell.recievedMessageLbl.sizeToFit()

            
            cell.configCell(message: message)
            
//            if dummyBoolArray[indexPath.row] == true {
//
//                cell.recievedMessageView.isHidden = false
//                cell.sentMessageView.isHidden = true
//
//                cell.recievedMessageLbl.text = dummyMessageArray[indexPath.row]
//                cell.receivedTimeLabel.text = "10:26 AM"
//
//            }else {
//
//                cell.recievedMessageView.isHidden = true
//                cell.sentMessageView.isHidden = false
//
//                cell.sentMessageLbl.text = dummyMessageArray[indexPath.row]
//                cell.sentTimeLabel.text = "10:26 AM"
//            }
            
//            let tapAtCell = UITapGestureRecognizer(target: self, action: #selector(tapOverTheCell(gesture:)))
//
//            tapAtCell.numberOfTapsRequired = 1
//
//            cell.addGestureRecognizer(tapAtCell)
            
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
    
   @objc func tapOverTheCell(gesture: UITapGestureRecognizer) {
        
    if isLongPressed {
        
        self.longPressView.isHidden = false
        
        let touchPoint = gesture.location(in: self.view)
        
        let indexPath = chatTableView.indexPathForRow(at: touchPoint)
        
        let cell = chatTableView.cellForRow(at: indexPath!) as! mainChatScreenTableViewCell
        
        if cell.checkImage.image == UIImage(named: "un-check") {
            
            cell.checkImage.image = UIImage(named: "check_blue")
            
            // open pop up view
            
        }else {
            
            cell.checkImage.image = UIImage(named: "un-check")
            
            
        }
        
        self.chatTableView.reloadData()
    } else {
        
        self.longPressView.isHidden = true
        
    }
    
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isLongPressed {
//
            let cell = chatTableView.cellForRow(at: indexPath) as! mainChatScreenTableViewCell
//
            if cell.checkImage.image == UIImage(named: "un-check") {

//                cell.checkImage.image = UIImage(named: "check_blue")
                
                checkImageArray[indexPath.row] = UIImage(named: "check_blue")!
                
                isSelected = true

                // open pop up view

            }else {

//                cell.checkImage.image = UIImage(named: "un-check")
                
                checkImageArray[indexPath.row] = UIImage(named: "un-check")!
                
                isSelected = false
            }

    }
    
        
        chatTableView.reloadData()
    }
    
    
    // long press action
    
    
    @IBAction func addTaskAction(_ sender: Any) {
   
        print("add task btn pressed")
        self.longPressView.isHidden = true
    
    }
    
    @IBAction func replyAction(_ sender: Any) {
        
        print("reply btn pressed")
        self.longPressView.isHidden = true
        
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        
        print("forward btn pressed")
        self.longPressView.isHidden = true
        
    }
    @IBAction func copAction(_ sender: Any) {
        
        print("copy btn pressed")
        self.longPressView.isHidden = true
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        print("delete btn pressed")
        self.longPressView.isHidden = true
        
        
    }
    
    
    func loadData() {
        
        print("message id load data::\(String(describing: messageId))")
        
//        Database.database().reference().child("user").child(currentUser!).child("outbox_new").queryEqual(toValue: messageId).observe(.value, with: { (snapshot) in
    
        
        Database.database().reference().child("messages").child(messageId).observe(.value, with: { (snapshot) in
        
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                self.messages.removeAll()
                
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
////        messageSend()
//        messageSendnew()
//
//        return true
//    }
    func messageSendnew(){
        
        
        
        if (typeMessageTextField.text != nil && typeMessageTextField.text != "") {
            
            print("recipient id::::\(String(describing: recipient))")
            
            
            if messageId == nil {
                
                let post: Dictionary<String, AnyObject> = [
                    "messageText": typeMessageTextField.text as AnyObject,
                    "sender": recipient as AnyObject,
                    "timestamp": NSDate().timeIntervalSince1970 as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "chatMessageType": "TEXT" as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                    
                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
                    "timestamp": NSDate().timeIntervalSince1970 as AnyObject
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
                    "timestamp":NSDate().timeIntervalSince1970 as AnyObject
                ]
                
//                messageId = Database.database().reference().child("messages").childByAutoId().key
//
//                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
//                print("message id::::\(String(describing: messageId))")
                
                messageId = Database.database().reference().child(recipient).child("inbox_new").childByAutoId().key
                
                
                let firebase_recipient_Message = Database.database().reference().child("user").child(recipient).child("inbox_new").child(messageId)
                    
                    firebase_recipient_Message.setValue(post)
                
                if currentUser != nil {
                    
                    let firebase_currentUser_Message = Database.database().reference().child("user").child(currentUser!).child("outbox_new").child(messageId)
                    
                    firebase_currentUser_Message.setValue(post)
                }
            
              
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("messages").child(messageId)

                recipentMessage.setValue(recipientMessage)

                let userMessage = Database.database().reference().child("user").child(currentUser!).child("messages").child(messageId)

                userMessage.setValue(message)
                
                loadData()
                
            } else if messageId != "" {
                
                let post: Dictionary<String, AnyObject> = [
                    
                    "messageText": typeMessageTextField.text as AnyObject,
                    "sender": recipient as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject,
                    "timestamp": NSDate().timeIntervalSince1970 as AnyObject,
                    "chatId" : userContactNumber as AnyObject,
                    "from": userContactNumber as AnyObject,
                    "chatMessageType": "TEXT" as AnyObject,
                    "chatMessageId": messageId as AnyObject,
                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": NSDate().timeIntervalSince1970 as AnyObject
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": NSDate().timeIntervalSince1970 as AnyObject
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
                
                messageId = Database.database().reference().child(recipient).child("inbox_new").childByAutoId().key
                
                print("new message id:::\(messageId)")
                
                
                let firebase_recipient_Message = Database.database().reference().child("user").child(recipient).child("inbox_new").child(messageId)
                
                firebase_recipient_Message.setValue(post)
                
                let firebase_currentUser_Message = Database.database().reference().child("user").child(currentUser!).child("outbox_new").child(messageId)
                
                firebase_currentUser_Message.setValue(post)
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("messages").child(messageId)

                recipentMessage.setValue(recipientMessage)

                let userMessage = Database.database().reference().child("user").child(currentUser!).child("messages").child(messageId)

                userMessage.setValue(message)
                
                
                loadData()
            }
            
            typeMessageTextField.text = ""
        }
        
        self.typeMessageTextField.resignFirstResponder()
        
        self.chatTableView.reloadData()
        
        moveToBottom()
        
        
    }
        
    func messageSend(){
        
        
        
        if (typeMessageTextField.text != nil && typeMessageTextField.text != "") {
            
            print("recipient id::::\(String(describing: recipient))")
            
            
            if messageId == nil {
                
                let post: Dictionary<String, AnyObject> = [
                    "message": typeMessageTextField.text as AnyObject,
                    "sender": recipient as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
//                    "timestamp": ServerValue.timestamp() as AnyObject
                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
//                    "timestamp": ServerValue.timestamp() as AnyObject
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                ]
                
                messageId = Database.database().reference().child("messages").childByAutoId().key
//                messageId = Database.database().reference().child("user").child(currentUser!).child("outbox").childByAutoId().key
                
                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
                print("message id::::\(String(describing: messageId))")
//                let firebaseMessage = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId).childByAutoId()
                
                firebaseMessage.setValue(post)
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("messages").child(messageId)
                
                recipentMessage.setValue(recipientMessage)
                
                let userMessage = Database.database().reference().child("user").child(currentUser!).child("messages").child(messageId)
                
                userMessage.setValue(message)
                
                loadData()
                
            } else if messageId != "" {
                
                let post: Dictionary<String, AnyObject> = [
                    "message": typeMessageTextField.text as AnyObject,
                    "sender": recipient as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject

                ]
                
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": recipient as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                ]
                
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": typeMessageTextField.text as AnyObject,
                    "recipient": currentUser as AnyObject,
                    "timestamp": Int(NSDate().timeIntervalSince1970) as AnyObject
                ]
                
                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
//                   let firebaseMessage = Database.database().reference().child("user").child(currentUser!).child("outbox").child(messageId).childByAutoId()
                
                firebaseMessage.setValue(post)
                
                let recipentMessage = Database.database().reference().child("user").child(recipient).child("messages").child(messageId)
                
                recipentMessage.setValue(recipientMessage)
                
                let userMessage = Database.database().reference().child("user").child(currentUser!).child("messages").child(messageId)
                
                userMessage.setValue(message)
                
                loadData()
            }
            
            typeMessageTextField.text = ""
        }
        
        recordView.isHidden = true
        
        self.typeMessageTextField.resignFirstResponder()
        
        self.chatTableView.reloadData()
      
        moveToBottom()


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
        
        print("typign count \(typeMessageTextField.text?.count)")
        
        
        if typeMessageTextField.text!.count >= 1 {
            
            btnRecordOrSend.setImage(UIImage(named: "btn_send2"), for: .normal)
            
        }else {
            
            btnRecordOrSend.setImage(UIImage(named: "btn voice"), for: .normal)
        }
        
    }

    
   
    
}//class

//extension MainChatScreenController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//
//
//
//    }
//
//}

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
        
        if(isRecording)
        {
            finishAudioRecording(success: true)
            recordAudioButton.setImage(UIImage(named: "Record"), for: .normal)
//            play_btn_ref.isEnabled = true
            isRecording = false
        }
        else
        {
            setup_recorder()
            isRecording = true
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            recordAudioButton.setImage(UIImage(named: "stop_Record"), for: .normal)
//            play_btn_ref.isEnabled = false
            
        }
        
    }
    
    @objc func sendRecord(sender: UIButton) {
        
      
        
    }
    
    @objc func openKeyboard(sender: UIButton) {
        
        recordView.isHidden = true
        
        typeMessageTextField.becomeFirstResponder()
        
    }
    
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
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
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        }
        else{
            print("error while finishing audio record")
        }
    }
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
//                try session.setCategory(AVAudioSession.Category.playAndRecord, with: .mixWithOthers)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: AVAudioSession.CategoryOptions.mixWithOthers)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                print("catched some error during recording")
            }
        }else {
            print("please enable audio access for catch app")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        
    }
}

extension MainChatScreenController {
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
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
            
            btnRecordOrSend.setImage(UIImage(named: "btn_send2"), for: .normal)
            
            
        }else {
            
            recordView.isHidden = false
            
            btnRecordOrSend.setImage(UIImage(named: "btn voice"), for: .normal)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        typeMessageTextField.resignFirstResponder()//
        
        recordView.isHidden = true
        
        messageSend()
        
//        messageSendnew()

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
////             cell.checkImage.isHidden = false
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
//
//                cell.recievedMessageView.frame.origin.x = cell.checkImage.frame.origin.x + cell.checkImage.frame.width + 35
//
////                cell.checkImage.isHidden = false
////
//
//
//            })
//        }
//
//
//
//        if gesture.state == .ended {
//
//            cell.isUserInteractionEnabled = true
//
//
//        }
//
        
        self.groupButton.setImage(UIImage(named: "Cross_close"), for: .normal)
        
        chatTableView.reloadData()
        
    }
    
    @objc func swipeToReply(gesture: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
    
//            self.bottomBarView.frame.origin.y = self.bottomBarView.frame.origin.y - (120 - self.bottomBarHeightConstant.constant)
//
//            self.bottomBarHeightConstant.constant = 120
//
//            self.bottomBarView.frame.size.height = 120
            
            // alternate method
            
//            self.bottomBarView.layer.cornerRadius = 1
            
            let touchPoint = gesture.location(in: self.chatTableView)
            
            let indexpath = self.chatTableView.indexPathForRow(at: touchPoint)
            
            let cell = self.chatTableView.cellForRow(at: indexpath!) as! mainChatScreenTableViewCell
            
            print("cell text",self.messages[(indexpath?.row)!].message)
            
            self.bottomBarView.roundCorners(corners: [], radius: 1.0)
          
            self.bottomBarView.clipsToBounds = true
            
            let viewHeight = 80
            
            let replyView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: Int(self.bottomBarView.frame.minY) - Int(self.bottomBarView.frame.size.height - 10)), size: CGSize(width: Int(self.bottomBarView.frame.width), height: viewHeight)))
            
            let replySubView = UIView(frame: CGRect(x: 10, y: 10, width: replyView.frame.width - (20), height: 60))
            
            replyView.backgroundColor = .white
            
            replySubView.backgroundColor = UIColor(hex: "EAF4FF")
            
            self.view.addSubview(replyView)
            
            replyView.addSubview(replySubView)
            
            // rounded corners
            
            replyView.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)
            
            replySubView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 5.0)
            
            let nameLabel = UILabel(frame: CGRect(x: 7, y: 7, width: 225, height: 22))
            
            nameLabel.textColor = UIColor(hex: "1183FF")
            
            if self.messages[(indexpath?.row)!].sender == self.messages[(indexpath?.row)!].currentUser {
                
               nameLabel.text = chatUserName
                
            }else {
                
                 nameLabel.text = "You"
                
            }
       
            nameLabel.font = UIFont(name: "Muli-Bold", size: 15.0)
            
            replySubView.addSubview(nameLabel)
            
            let messageLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.maxY + 5, width: 225, height: 22))
            
            messageLabel.textColor = UIColor(hex: "5B799C")
            
            messageLabel.text = self.messages[(indexpath?.row)!].message
            
            messageLabel.font = UIFont(name: "Muli-Regular", size: 14.0)
            
            replySubView.addSubview(messageLabel)
            
        })
    }
}


// group button action

extension MainChatScreenController {
    
    @objc func groupButtonOrClose(sender: UIButton) {
        
        isLongPressed = false
        
        isSelected = false
        
        if groupButton.imageView?.image == UIImage(named: "Cross_close") {
            
            groupButton.setImage(UIImage(named: "Group"), for: .normal)
            
            chatTableView.reloadData()
            
        }else {
            
            groupButton.setImage(UIImage(named: "Cross_close"), for: .normal)
            
        }
    
    }
}

//extension Date {
//    var ticks: UInt64 {
//        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
//    }
//}

