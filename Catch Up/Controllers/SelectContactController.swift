//
//  SelectContactController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class SelectContactController: UIViewController {
    
    @IBOutlet weak var selectContactTableView: UITableView!
    
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var navigationTempView: UIView!
    
    @IBOutlet weak var addNewGroup: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        addNewGroup.layer.cornerRadius = 20
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            
            StatusbarView.backgroundColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1)
        }
        
        self.navigationController?.navigationBar.barStyle = .black

    }
    
 
}

extension SelectContactController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectContactTableView.dequeueReusableCell(withIdentifier: "cell") as! SelectContactTableViewCell
        
        return cell
    }
    
    
    
    
}
