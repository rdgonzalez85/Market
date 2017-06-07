//
//  CurrencyService.swift
//  Market
//
//  Created by rgonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit
import Alamofire


typealias ReturnBlock = ([Currency]?, NSError?) -> Void

class CurrencyService {

    static let instance = CurrencyService()
    var apiKey: String?
    
    fileprivate var currencies: [Currency]?
    
    fileprivate let url = "http://apilayer.net/api/live"
    fileprivate let AccessKey = "access_key"
    
    func getCurrencies(completitionHandler: @escaping ReturnBlock) {
        if currencies != nil && (currencies?.count)! > 0 {
            completitionHandler(self.currencies, nil)
        } else {
            // we need to have an apiKey
            assert(apiKey != nil, "apiKey should be set")
            if let apiKey = apiKey {
                let params = [AccessKey:apiKey]
                Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                    if let jsonResponse = response.result.value as? NSDictionary {
                        self.currencies = Currency.parseDictionary(jsonResponse)
                        completitionHandler(self.currencies, nil)
                    } else {
                        completitionHandler(nil, NSError(domain: "Market", code: -1111, userInfo: nil))
                    }
                }
            }
        }
    }
}
