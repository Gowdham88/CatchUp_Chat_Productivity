//
//  CreateGroupController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/22/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class CreateGroupController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    
    
    @IBOutlet weak var curvedBackupView: UIView!
    
    @IBOutlet weak var groupImageView: UIImageView!
    
    @IBOutlet weak var groupNameField: UITextField!
    
    @IBOutlet weak var participantsLabel: UILabel!
    
    @IBOutlet weak var groupedUsersTableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        groupImageView.layer.cornerRadius = groupImageView.frame.height/2
    }
    


}


extension CreateGroupController: UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupedUsersTableview.dequeueReusableCell(withIdentifier: "cell") as! CreateGroupTableViewCell
        return cell
    }
 
}
