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
    
    @IBOutlet weak var addPeopleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        addNewGroup.layer.cornerRadius = 20
        
        if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            StatusbarView.backgroundColor = UIColor(red: 15/255, green: 110/255, blue: 255/255, alpha: 1)
//            setGradientBackground(view: StatusbarView)
            
            StatusbarView.setGradientBackground(view: StatusbarView)
        }
        self.navigationController?.navigationBar.barStyle = .black

    }
    @IBAction func didTappedAddPeople(_ sender: Any) {
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    //    func setGradientBackground(view: UIView) {
//
//        let colorTop =  UIColor(hex: "5FABFF").cgColor
//
//        let colorBottom = UIColor(hex: "007AFF").cgColor
//
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [colorTop, colorBottom]
//
////        gradientLayer.locations = [0.5, 0.0]
//
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
//
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
//
//        gradientLayer.frame = view.bounds
//
//        view.layer.insertSublayer(gradientLayer, at:0)
//    }
    
 
}

extension UIView {
    
    func setGradientBackground(view: UIView) {
        
        let colorTop =  UIColor(hex: "5FABFF").cgColor
        
        let colorBottom = UIColor(hex: "007AFF").cgColor
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [colorTop, colorBottom]
        
        //        gradientLayer.locations = [0.5, 0.0]
        
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
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
