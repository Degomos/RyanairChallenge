//
//  ShowAlert.swift
//  RyanairMobileTest
//
//  Created by degomos on 24/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation
import UIKit

class ShowAlert {
    
    /**
     * Function show 
     * Show Alert on Ui
     * @param title string to show to user on title
     * @param message string to show to user on message
     * @param vc viewcontroller
     */
    class func show(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
