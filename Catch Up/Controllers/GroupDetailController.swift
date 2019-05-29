//
//  GroupDetailController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/22/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class GroupDetailController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var moreOptionButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var backupCurvedView: UIView!
    
    @IBOutlet weak var addParticipantsLabel: UILabel!
    
    @IBOutlet weak var addParticipantsView: UIView!
    
    @IBOutlet weak var groupDetailTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension GroupDetailController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupDetailTableView.dequeueReusableCell(withIdentifier: "cell") as! GroupDetailTableCell
        
        return cell
    }
    
    
   
}
