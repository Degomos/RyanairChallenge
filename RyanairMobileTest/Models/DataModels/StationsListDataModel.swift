//
//  StationsListDataModel.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

class StationsListDataModel {
    var stations: [NSDictionary]!
    
    init(json: NSDictionary) {
        self.stations = ((json["stations"] as? [NSDictionary]) != nil) ? (json["stations"] as? [NSDictionary]) : []
    }
}
