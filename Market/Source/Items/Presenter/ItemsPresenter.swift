//
//  ItemsPresenter.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/3/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

protocol ItemsPresenterDelegateProcol {
    func itemsLoaded()
    func updateCartItems(_ totalItems: Int)
}

class ItemsPresenter: TableViewPresenterProtocol {
    
    var sectionItems = [Int]()
    
    internal var items: [TableViewPresentableItemProtocol]? {
        didSet {
            if let itemsCount = items?.count {
                sectionItems = [itemsCount]
            }
            delegate?.itemsLoaded()
        }
    }

    var delegate: ItemsPresenterDelegateProcol?
    
    fileprivate var cartItems: [Item]? {
        didSet {
            guard let itemCount = cartItems?.count else {
                return
            }
            delegate?.updateCartItems(itemCount)
        }
    }
    
    init() {
        self.setupItems()
    }
    
    internal func setupItems() {
        ItemService.getItems { (itemsResponse, error) in
            if let newItems = itemsResponse {
                self.items = newItems
            }
            if error != nil {
                // show error
            }
        }
        self.cartItems = [Item]()
    }
    
    func addItemToCart(_ item: Item) {
        cartItems?.append(item)
    }
    
    func getCartItems() -> [Item]? {
        return cartItems
    }
}
