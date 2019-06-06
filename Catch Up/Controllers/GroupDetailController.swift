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
    
    
 // popup view
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var groupDescInPopUp: UITextView!
    
    @IBOutlet weak var popUpCloseButton: UIButton!
    
    @IBOutlet weak var threeDotPopUp: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backupCurvedView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        popUpView.isHidden = true
        
        threeDotPopUp.isHidden = true
        
        popUpView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 7.0)
        
        threeDotPopUp.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 7.0)
    }
    
    
    @IBAction func didTappedViewContact(_ sender: Any) {
        
        threeDotPopUp.isHidden = true
    }
    
    @IBAction func didTappedRemoveUser(_ sender: Any) {
        
        threeDotPopUp.isHidden = true
    }
    
}

extension GroupDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupDetailTableView.dequeueReusableCell(withIdentifier: "cell") as! GroupDetailTableCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(threeDotTap(gesture:)))
        
        tap.numberOfTapsRequired = 1
        
        cell.moreOptionButton.isUserInteractionEnabled = true
        
        cell.moreOptionButton.tag = indexPath.row
        
        cell.moreOptionButton.addGestureRecognizer(tap)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
  
}

extension GroupDetailController {
    
    @objc func threeDotTap(gesture: UITapGestureRecognizer) {
    
    let tag = gesture.view?.tag
    
    let point = gesture.location(in: self.view)
    
    print(" points are \(point.y)")
    
    print("tag of selected item",tag as Any)
        
    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
        
        self.threeDotPopUp.isHidden = false
        
        self.threeDotPopUp.frame.origin.y = point.y - (self.threeDotPopUp.frame.height + 15)
        
        self.threeDotPopUp.frame.origin.x = point.x - (self.threeDotPopUp.frame.width - 10)
        
       
    })
        
    }
}
