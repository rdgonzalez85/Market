//
//  Item.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

struct Item: TableViewPresentableItemProtocol {

    let name: String
    let price: Float
    let currency: Currency
    let quantity: String
    let imageURL: String
    
    init(_ name: String, price: Float, currency: Currency, quantity: String, imageURL: String) {
        self.name = name
        self.price = price
        self.currency = currency
        self.quantity = quantity
        self.imageURL = imageURL
    }
    
    fileprivate enum Keys: String {
        case Item = "item"
        case Name = "name"
        case Price = "price"
        case Currency = "currency"
        case Quantity = "quantity"
        case ImageURL = "imageURL"
    }
    
    func priceString() -> String {
        return String(format: "%.2f", price)
    }
}

// JSON PARSING
extension Item {
    static func parseItems(_ itemArray: [Any]?) -> [Item]? {
        guard let itemArray = itemArray as? [NSDictionary]  else {
            return nil
        }
        
        var items = [Item]()
        
        for item in itemArray {
            if let itemDictionary = item[Keys.Item.rawValue] as? NSDictionary, let nItem = parseItem(itemDictionary) {
                items.append(nItem)
            }
        }
        
        
        return items
    }
    
    static func parseItem(_ itemDictionary: NSDictionary) -> Item? {
        guard let name = itemDictionary[Keys.Name.rawValue] as? String, let price = itemDictionary[Keys.Price.rawValue] as? Float, let currency = itemDictionary[Keys.Currency.rawValue] as? String, let quantity = itemDictionary[Keys.Quantity.rawValue] as? String, let imageURL = itemDictionary[Keys.ImageURL.rawValue] as? String  else {
            return nil
        }
        
        // all prices are in USD
        return Item(name, price: price, currency: Currency(currency, exchangeRate: 1, currencyExchange: currency), quantity: quantity, imageURL: imageURL)
    }
}



