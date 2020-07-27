//
//  SelectionTableViewCell.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    
    func setUpTableViewCell(data: StationsItemDataModel) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        let paragraphTwo = NSMutableParagraphStyle()
        paragraphTwo.alignment = .right
        
        lblCode.attributedText = NSMutableAttributedString(string: data.code, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus)), NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.paragraphStyle: paragraphTwo])
        
        lblName.attributedText = NSMutableAttributedString(string: data.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium)), NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph])
        
        lblCountryName.attributedText = NSMutableAttributedString(string: data.countryName, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium)), NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph])
    }
}
