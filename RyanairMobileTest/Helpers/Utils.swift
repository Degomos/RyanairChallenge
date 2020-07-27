//
//  Utils.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//
import UIKit
import Foundation

class Utils {
    static func selectionListViewController(selectedStation: SelectedStation, viewController: UIViewController) {
        guard let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionListViewController") as? SelectionListViewController else { return}
        destination.delegate = viewController as? SelectionListViewControllerDelegate
        destination.selectedStation = selectedStation
        viewController.view.addSubview(destination.view)
        viewController.addChild(destination)
        viewController.didMove(toParent: viewController)
    }
    
    static func calendarViewController(viewController: UIViewController) {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        destination.delegate = viewController as? CalenderViewControllerDelegate
        viewController.view.addSubview(destination.view)
        viewController.addChild(destination)
        viewController.didMove(toParent: viewController)
    }
    
    static func passengerViewController(viewController: UIViewController) {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassengerViewController") as! PassengerViewController
        destination.delegate = viewController as? PassengerViewControllerDelegate
        viewController.view.addSubview(destination.view)
        viewController.addChild(destination)
        viewController.didMove(toParent: viewController)
    }
    
    static func ResultListViewController(viewController: UIViewController) {
        guard let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return}
        viewController.view.addSubview(destination.view)
        viewController.addChild(destination)
        viewController.didMove(toParent: viewController)
    }
    static func returnDateFromString(date: String) -> String {
        let strToDateformatter = DateFormatter()
        strToDateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dt = strToDateformatter.date(from: date)!
        let  dateToStrformatter = DateFormatter()
        dateToStrformatter.dateFormat = "yyyy-MM-dd"
        
        return dateToStrformatter.string(from: dt)
    }
    
    static func formatNumberDouble(value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.groupingSeparator = "."
           formatter.numberStyle = .decimal
           formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfEven
           formatter.locale = Locale(identifier: "fr_FR")
           let formattedString = formatter.string(for: value)
           
           return formattedString!
       }
}
