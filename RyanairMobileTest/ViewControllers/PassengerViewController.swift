//
//  CalenderViewController.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//
import UIKit

protocol PassengerViewControllerDelegate {
    func passenger(adt: Int, teen: Int, chd: Int)
}

class PassengerViewController: UIViewController {
    
    @IBOutlet weak var stackviewPassenger: UIStackView!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var adultsPI = PassengerItemView()
    var teensPI = PassengerItemView()
    var childrenPI = PassengerItemView()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: PassengerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setViewWithData()
    }
    //configure button
    func configure() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let txt = NSMutableAttributedString(string: "SELECT".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
        btnConfirm.backgroundColor = UIColor.blue
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.setAttributedTitle(txt, for: .normal)
    }
    
    //Setup with data
    func setViewWithData() {
        adultsPI.index = 0
        adultsPI.max = 6
        adultsPI.min = 1
        adultsPI.currentVal = appDelegate.adt
        adultsPI.updatePIDescription = "ADULTS".localized + ":" + "ADULTS_SUBTITLE".localized
        
        teensPI.index = 1
        teensPI.max = 6
        teensPI.min = 0
        teensPI.currentVal = appDelegate.teen
        teensPI.updatePIDescription = "TEENS".localized + ":" + "TEENS_SUBTITLE".localized
        
        childrenPI.index = 2
        childrenPI.max = 6
        childrenPI.min = 0
        childrenPI.currentVal = appDelegate.chd
        childrenPI.updatePIDescription = "CHILDREN".localized + ":" + "CHILDREN_SUBTITLE".localized
        
        stackviewPassenger.addArrangedSubview(adultsPI)
        stackviewPassenger.addArrangedSubview(teensPI)
        stackviewPassenger.addArrangedSubview(childrenPI)
    }
    
    @IBAction func btnConfirmTapped(_ sender: Any) {
        delegate?.passenger(adt: adultsPI.currentVal, teen: teensPI.currentVal, chd: childrenPI.currentVal)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}


