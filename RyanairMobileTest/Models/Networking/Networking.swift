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
    
    func getStations(onComplete: @escaping (StationsListDataModel?) -> ()) {
        var dataModel: StationsListDataModel?
        
        requester.proceedServerResquest(url: NETWK.URL.stBaseUrl + NETWK.URL.stPath, params: "") { responseObject in
            dataModel = StationsListDataModel(json: responseObject! as NSDictionary)
            onComplete(dataModel)
        }
    }
    
    func getSearchResult(origin: String, destination: String, dateout: String, adt: String, teen: String, chd: String, onComplete: @escaping (SearchResultListDataModel?) -> ()) {
        var dataModel: SearchResultListDataModel?
        
        var params = ""
        params += "origin=" + origin
        params += "&destination=" + destination
        params += "&dateout=" + dateout
        params += "&adt=" + adt
        params += "&teen=" + teen
        params += "&chd=" + chd
        params += "&roundtrip=false&ToUs=AGREED"

        requester.proceedServerResquest(url: NETWK.URL.stBaseUrl + NETWK.URL.searchPath, params: params) { responseObject in
            dataModel = SearchResultListDataModel(json: responseObject! as NSDictionary)
            onComplete(dataModel)
        }
    }
}
