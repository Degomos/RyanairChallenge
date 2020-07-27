//
//  StationsItemDataModel.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

//Model class for Stations(Airport) item
class StationsItemDataModel {
    var code: String!
    var name: String!
    var alternateName: String!
    var alias: [String]!
    var countryCode: String!
    var countryName: String!
    var countryAlias: String!
    var countryGroupCode: String!
    var countryGroupName: String!
    var timeZoneCode: String!
    var latitude: String!
    var longitude: String!
    var mobileBoardingPass: Bool!
    var markets: [MarketsItemDataModel]!
    var notices: String!
    var tripCardImageUrl: String!
    
    init(json: NSDictionary) {
        self.code = ((json["code"] as? String) != nil) ? (json["code"] as? String) : ""
        self.name = ((json["name"] as? String) != nil) ? (json["name"] as? String) : ""
        self.alternateName = ((json["alternateName"] as? String) != nil) ? (json["alternateName"] as? String) : ""
        self.alias = ((json["alias"] as? [String]) != nil) ? (json["alias"] as? [String]) : []
        self.countryCode = ((json["code"] as? String) != nil) ? (json["code"] as? String) : ""
        self.countryName = ((json["countryName"] as? String) != nil) ? (json["countryName"] as? String) : ""
        self.countryAlias = ((json["countryAlias"] as? String) != nil) ? (json["countryAlias"] as? String) : ""
        self.countryGroupCode = ((json["countryGroupCode"] as? String) != nil) ? (json["countryGroupCode"] as? String) : ""
        self.countryGroupName = ((json["countryGroupName"] as? String) != nil) ? (json["countryGroupName"] as? String) : ""
        self.timeZoneCode = ((json["timeZoneCode"] as? String) != nil) ? (json["timeZoneCode"] as? String) : ""
        self.latitude = ((json["latitude"] as? String) != nil) ? (json["latitude"] as? String) : ""
        self.longitude = ((json["longitude"] as? String) != nil) ? (json["longitude"] as? String) : ""
        self.mobileBoardingPass = ((json["mobileBoardingPass"] as? Bool) != nil) ? (json["mobileBoardingPass"] as? Bool) : false
        self.markets = ((json["markets"] as? [MarketsItemDataModel]) != nil) ? (json["markets"] as? [MarketsItemDataModel]) : []
        self.notices = ((json["notices"] as? String) != nil) ? (json["notices"] as? String) : ""
        self.tripCardImageUrl = ((json["tripCardImageUrl"] as? String) != nil) ? (json["tripCardImageUrl"] as? String) : ""
    }
}
