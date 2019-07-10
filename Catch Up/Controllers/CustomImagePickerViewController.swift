//
//  CustomImagePickerViewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/18/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class CustomImagePickerViewController: UIViewController {
    
    
    @IBOutlet var topBar: GradientView!
    
    @IBOutlet var cameraButton: UIButton!
    
    @IBOutlet var dismissButton: UIButton!
    
    @IBOutlet var curveView: UIView!
    
    @IBOutlet var albumNameLabel: UILabel!
    
    @IBOutlet var dropDownButton: UIButton!
    
    @IBOutlet var imagePickerCollectionView: UICollectionView!
    
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        curveView.roundCorners(corners: [.topLeft,.topRight], radius: 20.0)
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        
    }
    

}

extension CustomImagePickerViewController: UICollectionViewDelegate,UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imagePickerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagePickerCollectionViewCell
        
        return cell
    }
    
    
    
}
