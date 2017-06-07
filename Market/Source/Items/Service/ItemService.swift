//
//  ItemService.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit


typealias ItemsResponse = ([Item]?, NSError?) -> Void

class ItemService: NSObject {
    
    class func getItems(completitionHandler: ItemsResponse) {
        completitionHandler(Item.parseItems(loadItems()),nil)
    }
    
    static fileprivate let itemsResourcePath = "items"
    
    fileprivate class func loadItems() -> [Any]?{
        var items: [Any]?
        let bundle = Bundle(for: ItemService.self)
        
        if let path = bundle.url(forResource: itemsResourcePath, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                items = try JSONSerialization.jsonObject(with: jsonData) as? [Any]
            } catch {
                print("error trying to get \(itemsResourcePath) file")
            }
        }
        return items
    }
}
