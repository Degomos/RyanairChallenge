//
//  RestRequester.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import Foundation
import Alamofire

class RestRequester {
    func proceedServerResquest(url: String, params: String, successHandler: @escaping ([String: Any]?) -> ()) {
        self.proceedServerRequest(silentCall: false, url: url, params: params, successHandler: successHandler)
    }
    
    func proceedServerRequest(silentCall: Bool, url: String, params: String, successHandler: @escaping ([String: Any]?) -> ()) {
        if Reachability.isConnectedToNetwork() {
            AF.request(url + params, method: .get, encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success :
                    do {
                        let data = response.data!
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: Any]
                        successHandler(json)
                    } catch {
                        ShowAlert.show(title: "WARNING".localized, message: "ERROR_INFO".localized + "\(error)", vc: UIApplication.getTopViewController()!)
                    }
                    break
                case .failure(let error):
                    if !silentCall {
                        ShowAlert.show(title: "WARNING".localized, message: error.localizedDescription, vc: UIApplication.getTopViewController()!)
                    }
                    break
                }
            })
        } else {
            ShowAlert.show(title: "WARNING".localized, message: "NOT_INTERNET_CONNECTION".localized, vc: UIApplication.getTopViewController()!)
        }
    }
}
