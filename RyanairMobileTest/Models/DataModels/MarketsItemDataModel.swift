//
//  MarketsItemDataModel.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

class MarketsItemDataModel {
    var code: String!
    var group: String!
    
    init(json: NSDictionary) {
        self.code = ((json["code"] as? String) != nil) ? (json["code"] as? String) : ""
        self.group = ((json["group"] as? String) != nil) ? (json["group"] as? String) : ""
    }
}
