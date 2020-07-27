//
//  PassengersView.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

protocol PassengerViewDelegate {
    func passengers()
}

class PassengersView: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnPassenger: UIButton!
    @IBOutlet weak var lblPassenger: UILabel!
    @IBOutlet var containerView: UIView!
    
    var delegate: PassengerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.layer.cornerRadius = 5
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        let txtP = NSMutableAttributedString(string: "PASSENGERS".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(GENK.txtSize.sMedium))])
        lblPassenger.attributedText = txtP
        
        addSubview(containerView)
    }
    
    var updatePassengerInfo: String! {
        didSet {
            btnPassenger.titleLabel?.numberOfLines = 0
            btnPassenger.setAttributedTitle(setText(str: updatePassengerInfo), for: .normal)
        }
    }
    
    func setText(str: String) -> NSMutableAttributedString {
        let paragraphTwo = NSMutableParagraphStyle()
        paragraphTwo.alignment = .left
        let txt = NSMutableAttributedString(string: str + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraphTwo, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
        
        return txt
    }
    
    @IBAction func PassengerTapped(_ sender: UIButton) {
        delegate?.passengers()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PassengersView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
