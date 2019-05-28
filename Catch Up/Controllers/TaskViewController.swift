//
//  TaskViewController.swift
//  Catch Up
//
//  Created by User on 23/5/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import BottomPopup

class TaskViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var dateTargetLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgText.delegate = self
        
        profileImgView.setRounded()
        
        dayLbl.layer.cornerRadius = 10
        dayLbl.layer.borderWidth = 1.0
        
        taskView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (imageTapped(tapGestureRecognizer:)))
        profileImgView.isUserInteractionEnabled = true
        profileImgView.addGestureRecognizer(tapGesture)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("print1")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("print2")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopUpViewcontrollerViewController else { return }
        present(popupVC, animated: true, completion: nil)
       
    }
    
}
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension TaskViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}



