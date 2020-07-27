//
//  Networking.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation

class Networking {
    let requester = RestRequester()
    /**
     * Function getStations
     * Makes a get resquest to the server to fetch all stations
     * @return StationsListDataModel a list with stations(airport)
     */
    func getStations(onComplete: @escaping (StationsListDataModel?) -> ()) {
        var dataModel: StationsListDataModel?
        
        requester.proceedServerRequest(url: NETWK.URL.stBaseUrl + NETWK.URL.stPath, params: "") { responseObject in
            dataModel = StationsListDataModel(json: responseObject! as NSDictionary)
            onComplete(dataModel)
        }
    }
    /**
     * Function getSearchResult
     * Makes a get request to the server to fetch available flights
     * @param origin String flight origin
     * @param destination String flight destination
     * @param dateout String date of flight
     * @param adt String number of adults to fly
     * @param teen String number of teens to fly
     * @param chd String number children to fly
     * @return SearchResultListDataModel a list with available flights
     */
    func getSearchResult(origin: String, destination: String, dateout: String, adt: String, teen: String, chd: String, onComplete: @escaping (SearchResultListDataModel?) -> ()) {
        var dataModel: SearchResultListDataModel?
        
        var params = ""
        params += "origin=" + origin
        params += "&destination=" + destination
        params += "&dateout=" + dateout
        params += "&datein=&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=3"
        params += "&adt=" + adt
        params += "&teen=" + teen
        params += "&chd=" + chd
        params += "&roundtrip=false&ToUs=AGREED"
        
        requester.proceedServerRequest(url: NETWK.URL.searchBaseUrl + NETWK.URL.searchPath, params: params) { responseObject in
            dataModel = SearchResultListDataModel(json: responseObject! as NSDictionary)
            onComplete(dataModel)
        }
    }
}
