//
//  Currency.swift
//  Market
//
//  Created by rgonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

struct Currency: TableViewPresentableItemProtocol {

    let name: String
    let exchangeRate: Float
    let currencyExchange: String
    
    init(_ name: String, exchangeRate: Float, currencyExchange: String) {
        self.name = name
        self.exchangeRate = exchangeRate
        self.currencyExchange = currencyExchange
    }
    
    
    fileprivate enum Keys: String {
        case Source = "source"
        case Quotes = "quotes"
    }
    
}

// JSON PARSING
extension Currency {
    static func parseDictionary(_ dictionary:NSDictionary?) -> [Currency]? {
        guard dictionary != nil, let source = dictionary?[Keys.Source.rawValue] as? String , let quotes = dictionary?[Keys.Quotes.rawValue] as? NSDictionary else {
            return nil
        }
        
        var currencies = [Currency]()
        
        for quote in quotes.allKeys {
            if let exchangeRate = quotes[quote] as? Float, let quoteString = quote as? String {
                currencies.append(parseQuote(source, destination: quoteString, value: exchangeRate))
            }
            
        }
        
        return currencies
    }
    
    static func parseQuote(_ source: String, destination: String, value: Float) -> Currency {
        let destinationCurrency = destination.replacingOccurrences(of: source, with: "")
        
        return Currency(destinationCurrency, exchangeRate: value, currencyExchange: source )
    }
}

