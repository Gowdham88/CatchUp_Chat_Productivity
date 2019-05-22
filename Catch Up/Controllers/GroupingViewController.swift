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
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupingTableView.dequeueReusableCell(withIdentifier: "cell") as! NewGroupTableCell
        
        return cell
    }
 
}

extension GroupingViewController: UICollectionViewDataSource,UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = groupedUserCollectionView.dequeueReusableCell(withReuseIdentifier: "groupcell", for: indexPath) as! GroupedUsersCell
        
        return cell
    }
    
    
    
}
