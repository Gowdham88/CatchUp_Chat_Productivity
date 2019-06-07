//
//  TaskViewController.swift
//  Catch Up
//
//  Created by User on 23/5/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import BottomPopup
import VACalendar


class TaskViewController: UIViewController, UITextViewDelegate {
    
   
    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var dateTargetLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    
    // calendar outlets
    
    var didSelectDay: ((Date) -> Void)?
    @IBOutlet weak var calendarTopView: UIView!
    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "LLLL YYYY"
            let appereance = VAMonthHeaderViewAppearance(
                previousButtonImage: #imageLiteral(resourceName: "leftArrow"),
                nextButtonImage: #imageLiteral(resourceName: "rightArrow"),
                dateFormatter: dateFormatterr
            )
            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }
    
    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()

    
    @IBOutlet weak var calendarMainView: UIView!
    
//    @IBOutlet weak var calendarView: VACalendarView!
    
//    @IBOutlet var calendarView: VACalendarView!
   
    private var calendarView: VACalendarView!

    @IBOutlet var calendarAdjustView: UIView!
    
    @IBOutlet var overlayView: UIView!
    
    
    @IBOutlet var calendarButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgText.delegate = self
        
        profileImgView.setRounded()
        
        dayLbl.layer.cornerRadius = 10
        dayLbl.layer.borderWidth = 1.0
        
        taskView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (imageTapped(tapGestureRecognizer:)))
        profileImgView.isUserInteractionEnabled = true
        profileImgView.addGestureRecognizer(tapGesture)
        
        calendarMainView.isHidden = true
        self.overlayView.isHidden = true

        
        let tapOverlay = UITapGestureRecognizer(target: self, action: #selector(overlayTap(gesture:)))
        
        overlayView.addGestureRecognizer(tapOverlay)
        
    }
    
    @objc func overlayTap(gesture: UITapGestureRecognizer) {
        
        self.view.sendSubviewToBack(overlayView)
        overlayView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        

    }
    
    @IBAction func didTappedCloseCal(_ sender: Any) {
        
        
    }
    // calendar action
    
    @IBAction func didTappedCalendar(_ sender: Any) {
        
//        self.overlayView.isHidden = false
//        self.view.bringSubviewToFront(overlayView)
//        self.overlayView.addSubview(calendarMainView)
        calendarMainView.isHidden = false
        
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        calendarMainView.addSubview(calendarView)
        calendarMainView.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.6
            )
            calendarView.setup()
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("print1")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("print2")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "PopUpView") as? PopUpViewcontrollerViewController else { return }
        present(popupVC, animated: true, completion: nil)
       
    }
    
}
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension TaskViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}




extension TaskViewController: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

extension TaskViewController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        
        return UIFont(name: "Muli-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        
    }
    
    func verticalMonthTitleColor() -> UIColor {
        
        return UIColor(hex: "253E5B")
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return UIColor(hex: "253E5B")
    }
    
}

extension TaskViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
//            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
            return UIColor(hex: "B5C5D8")
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return UIColor(hex: "253E5B")
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return UIColor(hex: "5FABFF")
        default:
            return .clear
        }
    }
    
    func font(for state: VADayState) -> UIFont {
        return UIFont(name: "Muli-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension TaskViewController: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        calendarView.startDate = dates.last ?? Date()
        print(dates)
    }
    
}


