//
//  File.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

//Model class for Search flights item
class FlightsDataModel {
    var duration: String!
    var faresLeft: String!
    var flightKey: String!
    var flightNumber: String!
    var infantsLeft: String!
    var operatedBy: String!
    var regularFare: NSDictionary!
    var time: [String]!
    var timeUTC: [String]!
    
    init(json: NSDictionary) {
        self.duration = ((json["duration"] as? String) != nil) ? (json["duration"] as? String) : ""
        self.faresLeft = ((json["faresLeft"] as? String) != nil) ? (json["faresLeft"] as? String) : ""
        self.flightKey = ((json["flightKey"] as? String) != nil) ? (json["flightKey"] as? String) : ""
        self.flightNumber = ((json["flightNumber"] as? String) != nil) ? (json["flightNumber"] as? String) : ""
        self.infantsLeft = ((json["infantsLeft"] as? String) != nil) ? (json["infantsLeft"] as? String) : ""
        self.operatedBy = ((json["operatedBy"] as? String) != nil) ? (json["operatedBy"] as? String) : ""
        self.regularFare = ((json["regularFare"] as? NSDictionary) != nil) ? (json["regularFare"] as? NSDictionary) : [:]
        self.time = ((json["time"] as? [String]) != nil) ? (json["time"] as? [String]) : []
        self.timeUTC = ((json["timeUTC"] as? [String]) != nil) ? (json["timeUTC"] as? [String]) : []
    }
}
