//
//  CalenderViewController.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//
import UIKit

protocol CalenderViewControllerDelegate {
    func exitCalendarView(currentYear: Int, currentMonth: Int, currentDay: Int)
}

class CalenderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var view_calendar: UIView!
    @IBOutlet weak var lbl_dom: UILabel!
    @IBOutlet weak var lbl_seg: UILabel!
    @IBOutlet weak var lbl_ter: UILabel!
    @IBOutlet weak var lbl_qua: UILabel!
    @IBOutlet weak var lbl_qui: UILabel!
    @IBOutlet weak var lbl_sex: UILabel!
    @IBOutlet weak var lbl_sab: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var view_bgView: UIView!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnLeft: UIButton!
    
    var delegate: CalenderViewControllerDelegate?
    
    // month variables
    var currentMonthIndex = 0
    var currentYear: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    var indexPathToday: Int = 0
    var currentDate: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view_bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view_calendar.layer.borderWidth = 2
        view_calendar.layer.borderColor = UIColor.blue.cgColor
        btn_cancel.setTitle("CANCEL".localized, for: .normal)
        btn_select.setTitle("SELECT".localized, for: .normal)
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        
        todaysDate = Calendar.current.component(.day, from: Date())
        currentDate = todaysDate
        firstWeekDayOfMonth = getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        
        lblName.text = "\(checkMonthWeek(name:"month")[currentMonthIndex - 1]) \(currentYear)"
        lbl_dom.text = checkMonthWeek(name: "week")[0]
        lbl_seg.text = checkMonthWeek(name: "week")[1]
        lbl_ter.text = checkMonthWeek(name: "week")[2]
        lbl_qua.text = checkMonthWeek(name: "week")[3]
        lbl_qui.text = checkMonthWeek(name: "week")[4]
        lbl_sex.text = checkMonthWeek(name: "week")[5]
        lbl_sab.text = checkMonthWeek(name: "week")[6]
        
        btnLeft.isEnabled=false
    }
    
    func checkMonthWeek(name: String) -> [String] {
        var result = [String]()
        if name == "month" {
            result = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
        } else {
            result = ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]
        }
        
        return result
    }
    
    @IBAction func btnLeftRightAction(_ sender: UIButton) {
        if sender.tag == 2 {
            currentMonthIndex += 1
            if currentMonthIndex > 12 {
                currentMonthIndex = 1
                currentYear += 1
            }
        } else if sender.tag == 1 {
            currentMonthIndex -= 1
            if currentMonthIndex == 0 {
                currentMonthIndex = 12
                currentYear -= 1
            }
        }
        lblName.text="\(checkMonthWeek(name: "month")[currentMonthIndex - 1]) \(currentYear)"
        didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    @IBAction func btn_moveToStepTwo(_ sender: UIButton) {
        if sender.tag == 2 {
            delegate?.exitCalendarView(currentYear: currentYear, currentMonth: currentMonthIndex, currentDay: currentDate)
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.view.frame =  CGRect (x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                self.view.layoutIfNeeded()
                self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParent()
            })
        } else if sender.tag == 1 {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! calendarCollectionViewCell
        cell.backgroundColor=UIColor.clear
        
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            if calcDate == todaysDate && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.backgroundColor = UIColor.yellow
                cell.layer.cornerRadius = cell.frame.size.height/3
            }
            cell.isHidden=false
            cell.lbl_collectionViewCell.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=false
                cell.lbl_collectionViewCell.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.lbl_collectionViewCell.textColor = UIColor.gray
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! calendarCollectionViewCell
        
        let calcDate = indexPath.row-firstWeekDayOfMonth+2
        if calcDate == todaysDate && currentMonthIndex == presentMonthIndex && currentYear == presentYear {}
        
        cell.backgroundColor = UIColor.gray
        cell.layer.cornerRadius = 8.0
        cell.lbl_collectionViewCell.textColor=UIColor.white
        currentDate = calcDate
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! calendarCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.lbl_collectionViewCell.textColor=UIColor.darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIScreen.main.nativeBounds.height <= 1136 {
            let width = collectionView.frame.width/9 - 8
            let height: CGFloat = 20
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.frame.width/7 - 8
            let height: CGFloat = 40
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex=monthIndex
        currentYear = year
        
        //for leap year, make february month of 29 days
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        collectionView.reloadData()
        btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
}

