//
//  File.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

class SearchResultListDataModel {
    var searchList: [NSDictionary]!
    
    init(json: NSDictionary) {
        self.searchList = ((json["trips"] as? [NSDictionary]) != nil) ? (json["trips"] as? [NSDictionary]) : []
    }
}

