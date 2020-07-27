//
//  ResultTableViewCell.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    
    func setUpTableViewCell(data: RegularFareDataModel, date: String, flightNumber: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        let paragraphTwo = NSMutableParagraphStyle()
        paragraphTwo.alignment = .right
        
        lblCode.attributedText = NSMutableAttributedString(string: "REGULAR_FARE".localized + Utils.formatNumberDouble(value: data.amount), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus)), NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.paragraphStyle: paragraphTwo])
        
        lblName.attributedText = NSMutableAttributedString(string: "DATE".localized + Utils.returnDateFromString(date: date) , attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium)), NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph])
        
        lblCountryName.attributedText = NSMutableAttributedString(string: "FLIGHT_NUMBER".localized + flightNumber, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium)), NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph])
    }
}
