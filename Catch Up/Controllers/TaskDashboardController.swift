//
//  TaskDashboardController.swift
//  Catch Up
//
//  Created by CZ Ltd on 6/6/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class TaskDashboardController: UIViewController {
    
    
    @IBOutlet weak var topBar: GradientView!
    
    @IBOutlet weak var curvedBackgroundView: UIView!
    
    @IBOutlet weak var taskTitleView: UIView!
    
    @IBOutlet weak var taskDashboardTableView: UITableView!
    
    @IBOutlet weak var userImageAtTopBar: UIImageView!
    
    
     var imageTableArray = [UIImage(named: "sampleTower"),UIImage(named: "image"),UIImage(named: "profile_user"),UIImage(named: "sample_user"),UIImage(named: "sampleTower"),UIImage(named: "image")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        curvedBackgroundView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 17.0)
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
        
        userImageAtTopBar.layer.cornerRadius = userImageAtTopBar.frame.height/2
    }

}

extension TaskDashboardController: UITableViewDataSource,UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = taskDashboardTableView.dequeueReusableCell(withIdentifier: "cell") as! TaskDashboardTableCell
       
        var startingX = 30
        
        for i in 1 ... imageTableArray.count {
            
            print("Starting x val \(startingX)")
            let adjustView = UIView(frame: CGRect(x: startingX  , y:  60, width: 30, height: 30))
            adjustView.backgroundColor = .white
            
            let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageview.image = UIImage(named: "sampleTower")
            imageview.layer.cornerRadius = imageview.frame.height/2
            imageview.clipsToBounds = true
            imageview.borderColor = .red
            adjustView.addSubview(imageview)
        
            cell.taskMainView.addSubview(adjustView)
            
            startingX = startingX + 28
            
        }
        
        return cell
    }
    
    
    
    
}
