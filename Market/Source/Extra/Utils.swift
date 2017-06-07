//
//  Utils.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/6/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

class Utils {
    
    static fileprivate let infoResourcePath = "Info"
    static fileprivate let currencyApiKey = "CurrencyApiKey"
    
    class func apiKey() -> String?{
        var dictionary: NSDictionary?
        let bundle = Bundle(for: AppDelegate.self)
        
        if let path = bundle.url(forResource: infoResourcePath, withExtension: "plist") {
            dictionary = NSDictionary(contentsOf: path)
        }
        
        return dictionary?[currencyApiKey] as? String
    }
    
}
