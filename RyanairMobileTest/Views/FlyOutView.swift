//
//  FlyOutView.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

protocol FlyOutViewDelegate {
    func flyOutDate()
}

class FlyOutView: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblFlyOut: UILabel!
    @IBOutlet weak var btnFlyOut: UIButton!
    
    var delegate: FlyOutViewDelegate?
    
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
        let txtD = NSMutableAttributedString(string: "FLY_OUT".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(GENK.txtSize.sMedium))])
        lblFlyOut.attributedText = txtD
        
        addSubview(containerView)
    }
    
    var updateFlyOutDate: String! {
        didSet {
            btnFlyOut.titleLabel?.numberOfLines = 0
            btnFlyOut.setAttributedTitle(setText(str: updateFlyOutDate), for: .normal)
        }
    }
    
    func setText(str: String) -> NSMutableAttributedString {
        let paragraphTwo = NSMutableParagraphStyle()
        paragraphTwo.alignment = .left
        let txt = NSMutableAttributedString(string: str + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraphTwo, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
        
        return txt
    }
    
    @IBAction func TappedFlyOutDate(_ sender: UIButton) {
        delegate?.flyOutDate()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FlyOutView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
