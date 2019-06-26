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


//import CameraManager




class MainChatScreenController: JSQMessagesViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,IQAudioRecorderViewControllerDelegate,JSQMessagesCollectionViewCellDelegate {
  
    func messagesCollectionViewCellDidTapAvatar(_ cell: JSQMessagesCollectionViewCell!) {
        
    }
    
    func messagesCollectionViewCellDidTapMessageBubble(_ cell: JSQMessagesCollectionViewCell!) {
        
    }
    
    func messagesCollectionViewCellDidTap(_ cell: JSQMessagesCollectionViewCell!, atPosition position: CGPoint) {
        
    }
    
    func messagesCollectionViewCell(_ cell: JSQMessagesCollectionViewCell!, didPerformAction action: Selector!, withSender sender: Any!) {
        
    }
    

    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        
    }
    
  
let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   // navigation outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navProfileImage: UIImageView!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var navigationView: GradientView!
    @IBOutlet weak var threadBackupView: UIView!
    @IBOutlet weak var threadMainImageView: UIImageView!
    @IBOutlet weak var bottomBarView: UIView!
    
    
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
    var messages: [JSQMessage] = []
    var objectMessages: [NSDictionary] = []
    var loadedMessages: [NSDictionary] = []
    var allPictureMessages: [String] = []
    var initialLoadComplete = false
    var jsqAvatarDictionary: NSMutableDictionary?
    var avatarImageDictionary: NSMutableDictionary?
    var showAvatars = true
    var firstLoad: Bool?
    
    var outgoingBubble = JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    
    var incomingBubble = JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    
     let composeVC = JSQMessagesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        typeMessageTextField.delegate = self
        
        threadBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        threadMainImageView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        bottomBarView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        navProfileImage.layer.cornerRadius = navProfileImage.frame.height/2
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
          
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        bottomBarView.layer.masksToBounds = false
        recordView.layer.masksToBounds = false
        
       
        
        
        
//        picker?.delegate = self
        
        
        // button targetss
        
        openKeyboard.addTarget(self, action: #selector(openKeyboard(sender:)), for: .touchUpInside)
        
        recordDeleteButton.addTarget(self, action: #selector(deleteRecord(sender:)), for: .touchUpInside)
        
        recordAudioButton.addTarget(self, action: #selector(audioRecord(sender:)), for: .touchUpInside)
        
        sendRecordButton.addTarget(self, action: #selector(sendRecord(sender:)), for: .touchUpInside)
        
//        cameraManager = CameraManager()
        
//        cameraManager.shouldFlipFrontCameraImage = true
        
        checkPermission()
        
        recordView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        recordView.isHidden = true
        
        displayMessageInterface()
        
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
    
    @IBAction func didTappedAudioRecord(_ sender: Any) {
        
        recordView.isHidden = false
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
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

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



