//
//  GroupingViewController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/22/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class GroupingViewController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var curvedBackupView: UIView!
    @IBOutlet weak var groupingTableView: UITableView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var selectedParticipantsLabel: UILabel!
    @IBOutlet weak var groupedUserCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var nameTableArray = ["User name1","User name2","User name3","User name4","User name5","User name6","User name7","User name8"]
    
     var numberTableArray = ["0238423084","464532422","546454342","57463522443","56789756234","36457657543","2443656234","5673423242"]
    
    var imageTableArray = [UIImage(named: "sampleTower"),UIImage(named: "image"),UIImage(named: "profile_user"),UIImage(named: "sample_user"),UIImage(named: "sampleTower"),UIImage(named: "image"),UIImage(named: "profile_user"),UIImage(named: "sample_user")]
    
    var nameCollectionArray = [String]()

    var numberCollectionArray = [String]()

    var imageCollectionArray = [UIImage]()
    
    var collectionDict = [String:Any]()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return self.style
    }
    
    
    var style: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()

  curvedBackupView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
//  bottomBar.roundCorners(corners: [.topLeft, .topRight], radius: 20)
//       bottomBar.clipsToBounds = false
    
//        bottomBar.layer.masksToBounds = false
        bottomBar.layer.cornerRadius = 20.0
        bottomBar.clipsToBounds = false
        bottomBar.layer.shadowRadius = 10.0
        bottomBar.layer.shadowOpacity = 0.2
        bottomBar.layer.shadowColor = UIColor.gray.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 3 , height:3)
        
        bottomBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
//            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
//(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)

    }
    
//button actions
    
    @IBAction func didTappedBack(_ sender: Any) {
    }
    
    @IBAction func didTappedSearch(_ sender: Any) {
    }
    
    @IBAction func didTappedNext(_ sender: Any) {
    }
}

extension GroupingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameTableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupingTableView.dequeueReusableCell(withIdentifier: "cell") as! NewGroupTableCell
        cell.userName.text = nameTableArray[indexPath.row]
        cell.userPhoneNumber.text = numberTableArray[indexPath.row]
        cell.userImageView.image = imageTableArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = groupingTableView.cellForRow(at: indexPath) as! NewGroupTableCell
        
        if cell.selectStatusImage.image == UIImage(named: "Check") {
            let nameIndex = nameCollectionArray.index(of: nameTableArray[indexPath.row])
            nameCollectionArray.remove(at: nameIndex!)
            numberCollectionArray.remove(at: nameIndex!)
            imageCollectionArray.remove(at: nameIndex!)
            cell.selectStatusImage.image = UIImage(named: "Ellipse")
            cell.alpha = 1.0
            
        }else {
            nameCollectionArray.append(nameTableArray[indexPath.row])
            numberCollectionArray.append(numberTableArray[indexPath.row])
            imageCollectionArray.append(imageTableArray[indexPath.row]!)
            cell.selectStatusImage.image = UIImage(named: "Check")
//            collectionDict = ["name"   : nameCollectionArray,
//                              "number" : numberCollectionArray,
//                              "image"  : imageCollectionArray]
//
//            self.groupedUserCollectionView.reloadData()
            cell.alpha = 0.5
        }
        
        collectionDict = ["name"   : nameCollectionArray,
                          "number" : numberCollectionArray,
                          "image"  : imageCollectionArray]
        
        selectedParticipantsLabel.text = "PARTICIPANTS : " + "\(nameCollectionArray.count)"
        
//        if nameCollectionArray.count == 0 {
//            
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
//                
//                self.bottomBar.isHidden = true
//                
//            })
//
//        }else {
//            
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
//                
//                self.bottomBar.isHidden = false
//                
//                self.groupingTableView.frame.size.height = self.groupingTableView.frame.height - self.bottomBar.frame.height
//                
//            })
//        }
        
        self.groupedUserCollectionView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
       
    }
 
}

extension GroupingViewController: UICollectionViewDataSource,UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nameCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = groupedUserCollectionView.dequeueReusableCell(withReuseIdentifier: "groupcell", for: indexPath) as! GroupedUsersCell
        
        cell.groupedUserImageView.image = imageCollectionArray[indexPath.row]
        
//        for item in collectionDict {
//
//            print(" \(item.key) : \(item.value)")
//        }
        
        
        
        return cell
    }
    
    
    
}
