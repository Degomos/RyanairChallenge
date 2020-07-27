//
//  PassengerItemView.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

class PassengerItemView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblPassenger: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    var index = 0
    var max = 0
    var min = 0
    var currentVal = 0
    
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
        
        addSubview(containerView)
    }
    
    var updatePIDescription: String! {
        didSet {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
            
            let sp = updatePIDescription.split(separator: ":")
            
            let txt = NSMutableAttributedString(string: String(sp[0]) + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
            txt.append(NSAttributedString(string: String(sp[1]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(GENK.txtSize.sMedium))]))
            lblPassenger.attributedText = txt
            updateCurrentVal(val: currentVal)
        }
    }
    
    func updateCurrentVal(val: Int) {
        let paragraphTwo = NSMutableParagraphStyle()
        paragraphTwo.alignment = .center
        let txtT = NSMutableAttributedString(string: "\(val)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.paragraphStyle: paragraphTwo, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
        lblTotal.attributedText = txtT
    }
    
    @IBAction func btnAddSubTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            if currentVal > min && currentVal <= max {
                currentVal -= 1
                updateCurrentVal(val: currentVal)
            }
        } else if sender.tag == 2 {
            if currentVal >= min && currentVal < max {
                currentVal += 1
                updateCurrentVal(val: currentVal)
            }
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PassengerItemView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
