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
    /**
     * Function proceedServerRequest
     * Rest request to the server
     * @param url String url to the server
     * @param params String parameters to append to the url
     * @return successHandler json with response from server 
     */
    func proceedServerRequest(url: String, params: String, successHandler: @escaping ([String: Any]?) -> ()) {
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
                    ShowAlert.show(title: "WARNING".localized, message: error.localizedDescription, vc: UIApplication.getTopViewController()!)
                    break
                }
            })
        } else {
            ShowAlert.show(title: "WARNING".localized, message: "NOT_INTERNET_CONNECTION".localized, vc: UIApplication.getTopViewController()!)
        }
    }
}
