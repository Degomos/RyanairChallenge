//
//  RegularFareDataModel.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

class RegularFareDataModel {
    var amount: Double!
    var count: Int!
    var discountAmount: Int!
    var discountInPercent: Int!
    var hasDiscount: Int!
    var hasPromoDiscount: Int!
    var publishedFare: Double!
    var type: String!
    
    init(json: NSDictionary) {
        self.amount = ((json["amount"] as? Double) != nil) ? (json["amount"] as? Double) : 0.0
        self.count = ((json["count"] as? Int) != nil) ? (json["count"] as? Int) : 0
        self.discountAmount = ((json["discountAmount"] as? Int) != nil) ? (json["discountAmount"] as? Int) : 0
        self.discountInPercent = ((json["discountInPercent"] as? Int) != nil) ? (json["discountInPercent"] as? Int) : 0
        self.hasDiscount = ((json["hasDiscount"] as? Int) != nil) ? (json["hasDiscount"] as? Int) : 0
        self.hasPromoDiscount = ((json["hasPromoDiscount"] as? Int) != nil) ? (json["hasPromoDiscount"] as? Int) : 0
        self.publishedFare = ((json["publishedFare"] as? Double) != nil) ? (json["publishedFare"] as? Double) : 0.0
        self.type = ((json["type"] as? String) != nil) ? (json["type"] as? String) : ""
    }
}
