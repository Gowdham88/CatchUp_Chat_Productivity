//
//  CreateProfileController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateProfileController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var gradientCurveView: GradientView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var ref: DatabaseReference!
    
    var userPhoneNumber: String!

    var grantedContactsForProfileImage = [String:String]()
    
    var grantedContactsForProfileName = [String:String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        grantedContactsForProfileImage = ["435345345" : "5352525245",
                               "242342343" : "234234234",
                               "342342423" : "242424324"]
        
        grantedContactsForProfileName = ["isAllPermitted": "Y"]
        
        nameField.delegate = self
        imagePicker.delegate = self
        roundedTop(targetView: gradientCurveView, desiredCurve: 1)
        
         ref = Database.database().reference()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
        // profile image tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        profileImageView.isUserInteractionEnabled = true
        tapGesture.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(tapGesture)
        
        // nav bar settings
 
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func imageTapped(gesture: UITapGestureRecognizer) {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {
            
            self .present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didTappedSubmit(_ sender: Any) {
        
        let userName = nameField.text
        
        UserDefaults.standard.set(userName, forKey: "name")
        
        //updating the user details to firebase
        
//        var imgData: NSData = NSData(data: UIImageJPEGRepresentation(profileImageView.image!, 0.8)!)
        
        guard let imageData = profileImageView.image!.jpegData(compressionQuality: 0.75) else { return }
        
        let userID = Auth.auth().currentUser?.uid
        
        print("printing user id \(userID)")

        let imageStr = self.uploadProfileImageToFirebase(data: imageData as NSData, uid: userID!)
        
        let username = nameField.text
        
        print("user name \(username)")
        
    
        

    }
    
    func roundedTop(targetView:UIView?, desiredCurve:CGFloat?){
        
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x:bounds.origin.x - offset / 2,y: bounds.origin.y, width : bounds.size.width + offset, height :bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        targetView!.layer.mask = maskLayer
    }
}

extension CreateProfileController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.submitButton.frame.origin.y = self.submitButton.frame.origin.y - 280
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
            
            self.submitButton.frame.origin.y = self.submitButton.frame.origin.y + 280
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameField.resignFirstResponder()
    }
}

extension CreateProfileController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            profileImageView.contentMode = .scaleToFill
            
            profileImageView.image = pickedImage
        }
        
    }
}

extension CreateProfileController {
    
    
    func uploadProfileImageToFirebase(data:NSData,uid: String) -> String {
        var urlStr: String?
        let storageRef = Storage.storage().reference().child(userPhoneNumber).child("\(uid).jpg")
//        if data != nil {
            storageRef.putData(data as Data, metadata: nil, completion: { (metadata, error) in
                if(error != nil){
                    print("error occured in upload profile image to firebase function",error as Any)
                    return
                }
                guard let userID = Auth.auth().currentUser?.uid else {
                    return
                }
                // Fetch the download URL
                storageRef.downloadURL { url, error in
                    if let error = error {
                        // Handle any errors
                            print("error while downloading url",error)
                            return
                       
                    } else {
                        // Get the download URL for 'images/stars.jpg'
                        
                         urlStr = (url?.absoluteString)
                        print("printing url",urlStr)
                        
                        let username = self.nameField.text
                        let deviceID = UIDevice.current.identifierForVendor!.uuidString
                        
//                        let values = ["downloadURL": urlStr]
                       
                        let profileImageDict = ["premissionGrantedContacts": self.grantedContactsForProfileImage,
                                                "url"                      : urlStr ] as [String : Any]
                        
                        let profileNameDict = ["premissionGrantedContacts" : self.grantedContactsForProfileName,
                                               "userName"                  : username] as [String : Any]
                        let values = ["profileImage": profileImageDict,
                                      "profileName" : profileNameDict] as [String : Any]
                        self.addImageURLToDatabase(uid: userID, values: values as [String : AnyObject])
                        
                       
                        
                        self.ref.child("user").childByAutoId().setValue(["userName": username,
                                                                         "userPhotoThumbnail" : urlStr,
                                                                         "userContactNumber" : self.userPhoneNumber,
                                                                         "deviceId" : deviceID,
                                                                         "user_id" : uid])
                        
//                        self.ref.child(self.userPhoneNumber).setValue(["userName": username,
//                                                                "userPhotoThumbnail" : urlStr,
//                                                                "userContactNumber" : self.userPhoneNumber,
//                                                                "uid" : uid])
                        

//                        self.ref.setValue(["userName": username,
//                                           "userPhotoThumbnail" : urlStr,
//                                           "userContactNumber" : self.userPhoneNumber,
//                                           "deviceId" : deviceID,
//                                           "user_id" : uid])
                        
                        
                        let sb = UIStoryboard(name: "Chat", bundle: nil)
                        
                        let vc = sb.instantiateViewController(withIdentifier: "ChatDashboardController") as! ChatDashboardController
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            })
        
//        }
        
        return urlStr ?? ""
        
    }
    
    func addImageURLToDatabase(uid:String, values:[String:AnyObject]){
        let ref = Database.database().reference(fromURL: "https://schnellfirebase-dev.firebaseio.com")
        
        let usersReference = ref.child(userPhoneNumber)
        
        usersReference.updateChildValues(values) { (error, ref) in
            if(error != nil){
                print("error occured in add image url to database function",error as Any)
                return
            }
     
            
            self.parent?.dismiss(animated: true, completion: nil)
        }
        
    }

}
