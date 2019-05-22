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
        
  bottomBar.roundCorners(corners: [.topLeft, .topRight], radius: 20)
       
    
        
    }
    
//button actions
    
    @IBAction func didTappedBack(_ sender: Any) {
    }
    
    @IBAction func didTappedSearch(_ sender: Any) {
    }
    
    @IBAction func didTappedNext(_ sender: Any) {
    }
}
