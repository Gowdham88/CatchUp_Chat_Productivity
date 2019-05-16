//
//  ChatDashboardController.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/15/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit

class ChatDashboardController: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var navigationSubView: GradientView!
    
    @IBOutlet weak var tempView: UIView!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return self.style
    }
    
    @IBOutlet weak var addContactButton: UIButton!
    
    var style: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.style == .default {
            
            self.style = .lightContent
        }
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
           
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black
       
        tempView.roundCorners(corners: [.topLeft, .topRight], radius: 17.0)
        chatTableView.roundCorners(corners: [.topLeft, .topRight], radius: 17.0)
        userProfileImage.layer.cornerRadius = userProfileImage.frame.height / 2
    }
    

    @IBAction func didTappedAddContact(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectContactController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension ChatDashboardController: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        
        return cell
    }
    
    
   
}
