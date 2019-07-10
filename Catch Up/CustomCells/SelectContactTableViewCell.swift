//
//  SelectContactTableViewCell.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class SelectContactTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userContactNumber: UILabel!
    
    @IBOutlet weak var selectContactButton: UIButton!
    
    var searchDetail: Contacts!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }

    @IBAction func didTappedSelectContact(_ sender: Any) {
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state...
    }
    
    func configCell(searchDetail: Contacts) {
        
        self.searchDetail = searchDetail
        
        userName.text = searchDetail.userName
        
        let ref = Storage.storage().reference(forURL: searchDetail.userPhotoThumbnail)
        
            ref.getData(maxSize: 100000, completion: { (data, error) in
            
                if error != nil {
                
                print(" we couldnt upload the img")
                
            } else {
                
                if let imgData = data {
                    
                    if let img = UIImage(data: imgData) {
                        
                        self.userImage.image = img
                    }
                }
            }
            
        })
    }

}//class
