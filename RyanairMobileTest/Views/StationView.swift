//
//  StationView.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

protocol StationViewDelegate {
    func listStation(selectedStation: SelectedStation)
}

class StationView: UIView {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet var containerView: UIView!
    
    var delegate: StationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    //Configure view with data
    func configure() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.layer.cornerRadius = 5
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let txtF = NSMutableAttributedString(string: "FROM".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium))])
        let txtT = NSMutableAttributedString(string: "TO".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium))])
        lblFrom.attributedText = txtF
        lblTo.attributedText = txtT
        
        addSubview(containerView)
    }
    
    var updateFromInfo: StationsItemDataModel! {
        didSet {
            btnFrom.titleLabel?.numberOfLines = 0
            btnFrom.setAttributedTitle(setText(code: updateFromInfo.code, country: updateFromInfo.countryName), for: .normal)
        }
    }
    var updateToInfo: StationsItemDataModel! {
        didSet {
            btnTo.titleLabel?.numberOfLines = 0
            btnTo.setAttributedTitle(setText(code: updateToInfo.code, country: updateToInfo.countryName), for: .normal)
        }
    }
    
    func setText(code: String, country: String) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let txt = NSMutableAttributedString(string: code + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sLarge))])
        txt.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMedium))]))
        
        return txt
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            delegate?.listStation(selectedStation: SelectedStation.from)
        } else if sender.tag == 2 {
            delegate?.listStation(selectedStation: SelectedStation.to)
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StationView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
