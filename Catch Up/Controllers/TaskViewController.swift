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
        calendar.firstWeekday = 2
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()

    
    @IBOutlet weak var calendarMainView: UIView!
    
//    @IBOutlet weak var calendarView: VACalendarView!
    
//    @IBOutlet var calendarView: VACalendarView!
   
    private var calendarView: VACalendarView!

    @IBOutlet var calendarAdjustView: UIView!
    
    @IBOutlet var overlayView: UIView!
    
    @IBOutlet var isDateView: UIView!
    
    @IBOutlet var dateView: UIView!
    
    @IBOutlet var timeView: UIView!
    
    @IBOutlet var dateIndicator: UIView!
    
    @IBOutlet var timeIndicator: UIView!
    
    @IBOutlet var calendarButton: UIButton!
    
    @IBOutlet var isTimeView: UIView!
    
    var timeHourPickerView : UIPickerView!
    var timeMinsPickerView : UIPickerView!
    
    @IBOutlet var timePickerHourView: UIView!
    @IBOutlet var timePickerMinutesView: UIView!
    
    @IBOutlet var timeHourCollectionView: UICollectionView!
    @IBOutlet var timeMinsCollectionView: UICollectionView!
    
    var hourTimeArray = [String]()
    var minTimeArray  = [String]()
    
    var indexNumber : Int = 0
    var minsIndexNumber : Int = 0
    
    @IBOutlet var hourIncrementButton: UIButton!
    @IBOutlet var hourDecrementButton: UIButton!
    
    @IBOutlet var minsIncrementButton: UIButton!
    @IBOutlet var minsDecrementButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1 ... 12 {
            
            hourTimeArray.append("\(i)")
        }
        
        for i in 1 ... 60/15 {
            
            minTimeArray.append(String(format: "%02d", i * 15 ))
        }
        
        print("min time array \(minTimeArray)")
        
        
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
        
        let isCalendarTap = UITapGestureRecognizer(target: self, action: #selector(isCalendar(gesture:)))
        isDateView.isUserInteractionEnabled = true
        isCalendarTap.numberOfTapsRequired = 1
        isDateView.addGestureRecognizer(isCalendarTap)
        
        let isTimeTap = UITapGestureRecognizer(target: self, action: #selector(isTime(gesture:)))
        timeView.isUserInteractionEnabled = true
        isTimeTap.numberOfTapsRequired = 1
        timeView.addGestureRecognizer(isTimeTap)
        
//        minTimeArray.removeLast()
    
        
    }
    
    @objc func overlayTap(gesture: UITapGestureRecognizer) {
        
        self.view.sendSubviewToBack(overlayView)
        calendarView.removeFromSuperview()
        overlayView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        

    }
    
    @IBAction func didTappedCloseCal(_ sender: Any) {
        
        
    }
    // calendar action
    
    @IBAction func didTappedCalendar(_ sender: Any) {
        
        isCalendar()
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
    
    @IBAction func hourTimeUpButton(_ sender: Any) {
        
        
//        let visibleIndexPaths = timeHourCollectionView.indexPathsForVisibleItems
//
//        print("visible ones \(visibleIndexPaths)")
//
//        let visibleIndex = visibleIndexPaths.first
//
//        print("visible on button click",visibleIndex)
//
//        let nextHour = hourTimeArray[(visibleIndex!.row) + 1]
//
//        print("the real next",nextHour)
        
        scrollToNextCell()
        
    }
    
    func scrollToNextCell(){
        
        indexNumber += 1
        
//        //get cell size
//
//                let visibleIndexPaths = timeHourCollectionView.indexPathsForVisibleItems
//
//                print("visible ones \(visibleIndexPaths)")
//
//                let visibleIndex = visibleIndexPaths.first
//
////                print("visible on button click",visibleIndex)
//
//        let cell = timeHourCollectionView.cellForItem(at: visibleIndex!) as! TimeHourCollectionViewCell
//
//        print("print cell sizes",cell.frame.width,cell.frame.height)
//
//        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
//
//        //get current content Offset of the Collection view
//        let contentOffset = timeHourCollectionView.contentOffset
//
////        if timeHourCollectionView.contentSize.width <= timeHourCollectionView.contentOffset.x + cellSize.width
////        {
//
//            timeHourCollectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
//
//
////        } else {
////
////            timeHourCollectionView.scrollRectToVisible(CGRect(x: contentOffset.x, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
////
////        }
//
//        self.timeHourCollectionView.reloadData()
        
        if indexNumber < hourTimeArray.count {
            
            hourIncrementButton.isUserInteractionEnabled = true
            
            self.timeHourCollectionView.scrollToItem(at:IndexPath(item: indexNumber, section: 0), at: .bottom, animated: true)
        }else {
            
            hourIncrementButton.isUserInteractionEnabled = false
        }
        
    
    }
    
    
    @IBAction func hourTimeDownButton(_ sender: Any) {
        
        indexNumber -= 1
        
        if indexNumber >= 0 {
            
            hourDecrementButton.isUserInteractionEnabled = true
            
            self.timeHourCollectionView.scrollToItem(at:IndexPath(item: indexNumber, section: 0), at: .bottom, animated: true)
            
        }else {
            
            hourDecrementButton.isUserInteractionEnabled = false
        }
        
    }
    
    @IBAction func minsTimeUpButton(_ sender: Any) {
       
        minsIndexNumber += 1
        
        print("min index",minsIndexNumber)

        print("min array",minTimeArray)
        isDateView.isHidden = true
        isTimeView.isHidden = false
        calendarMainView.isHidden = false
        
        if minsIndexNumber < minTimeArray.count  {
            
            minsIncrementButton.isUserInteractionEnabled = true
            
            self.timeMinsCollectionView.scrollToItem(at:IndexPath(item: minsIndexNumber, section: 0), at: .bottom, animated: true)
            
        }else {
            
            minsIncrementButton.isUserInteractionEnabled = false
        }
        
       
        
    }
    
    @IBAction func minsTimeDownButton(_ sender: Any) {
        
        minsIndexNumber -= 1
        
        isDateView.isHidden = true
        isTimeView.isHidden = false
        calendarMainView.isHidden = false
        
        if minsIndexNumber >= 0 {
            
            minsIncrementButton.isUserInteractionEnabled = true
            
            self.timeMinsCollectionView.scrollToItem(at:IndexPath(item: minsIndexNumber, section: 0), at: .bottom, animated: true)
        }else {
            
            minsIncrementButton.isUserInteractionEnabled = false
        }
        
        
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

extension TaskViewController {
    
    @objc func isCalendar(gesture: UITapGestureRecognizer) {
        
        isCalendar()
        
    }
    
    @objc func isTime(gesture: UITapGestureRecognizer) {
        
        isTimePicker()
        
    }
    
    func isCalendar() {
        
        self.overlayView.isHidden = false
        self.view.bringSubviewToFront(overlayView)
        self.overlayView.addSubview(calendarMainView)
        calendarMainView.isHidden = false
        isTimeView.isHidden = true
        isDateView.isHidden = false
        
        timeIndicator.isHidden = true
        dateIndicator.isHidden = false
        
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
        calendarMainView.roundCorners(corners: [.topLeft,.topRight], radius: 20.0)
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.45
            )
            calendarView.setup()
        }
    }
    
    func isTimePicker() {
        
        self.overlayView.isHidden = false
        self.view.sendSubviewToBack(overlayView)
        calendarView.removeFromSuperview()
        self.view.bringSubviewToFront(overlayView)
//        overlayView.addSubview(isDateView)
        
        isDateView.isHidden = true
        isTimeView.isHidden = false
        
        timeIndicator.isHidden = false
        dateIndicator.isHidden = true
        
//        openTimePicker()
        
    }
}

//extension TaskViewController: UIPickerViewDelegate,UIPickerViewDataSource {
//
////    func numberOfComponents(in pickerView: UIPickerView) -> Int {
////
////        pickerView.subviews.forEach({
////            $0.isHidden = $0.frame.height < 1.0
////        })
////        return 1
////    }
////
////    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////
////       return 13
////    }
////
////    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////
////       return "\(row)"
////
////    }
////
////    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
////
////        var pickerLabel = view as? UILabel
////
////        if (pickerLabel == nil)
////        {
////            pickerLabel = UILabel()
////
////            pickerLabel?.font = UIFont(name: "Muli-Regular", size: 16)
////            pickerLabel?.textAlignment = .center
////            pickerLabel?.textColor = .blue
////        }
////
////        pickerLabel?.text = "\(row)"
////
////        return pickerLabel!
////
////    }
////
////    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////
//////        timerHourTextFiled.text = "\(row)"
////    }
//
//
//    func openTimePicker()  {
//
//
//        timeHourPickerView = UIPickerView()
//        timeHourPickerView.frame = CGRect(x: 0, y: 20, width: timePickerHourView.frame.width, height: timePickerHourView.frame.height - 40)
//        timeHourPickerView.dataSource = self
//        timeHourPickerView.delegate = self
//
//
//        timePickerHourView.addSubview(timeHourPickerView)
////        gradeTextField.text = gradePickerValues[0]
//
//    }
//
////    @objc func startTimeDiveChanged(sender: UIDatePicker) {
////        let formatter = DateFormatter()
////        formatter.timeStyle = .short
////        timerHourTextFiled.text = formatter.string(from: sender.date)
//////        timePicker.removeFromSuperview() // if you want to remove time picker
////    }
//}

extension TaskViewController: UICollectionViewDataSource,UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == timeHourCollectionView {
            
             return hourTimeArray.count
            
        }else {
            
            return minTimeArray.count
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == timeHourCollectionView {
            
            let cell = timeHourCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TimeHourCollectionViewCell
            
            cell.hourLabel.text = hourTimeArray[indexPath.row]
            
            return cell
            
        }else {
            
            let cell1 = timeMinsCollectionView.dequeueReusableCell(withReuseIdentifier: "MinsCell", for: indexPath) as! TimeMinsCollectionViewCell
            
            cell1.minsLabel.text = minTimeArray[indexPath.row]
            
            return cell1
        }
  
    }
    
//    fileprivate var pageSize: CGSize {
//
//        let layout = self.timeHourCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        var pageSize = layout.itemSize
//        if layout.scrollDirection == .horizontal {
//            pageSize.width += layout.minimumLineSpacing
//        } else {
//            pageSize.height += layout.minimumLineSpacing
//        }
//        return pageSize
//    }
    
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        let layout = timeHourCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
////        let pageSize = layout.itemSize
//        let pageSide = (layout.scrollDirection == .vertical) ? pageSize.width : pageSize.height
//        let offset = (layout.scrollDirection == .vertical) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//       let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//        print("currentpage::::\(currentPage)")
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        let visibleIndex = Int(targetContentOffset.pointee.x / timeHourCollectionView.frame.width)
//
//        print("the visible index is \(visibleIndex)")
//    }
//
    
    
}


