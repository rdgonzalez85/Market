//
//  ItemsPresenter.swift
//  Market
//
//  Created by rgonzalez on 6/5/17.
//  Copyright © 2017 RG. All rights reserved.
//

import XCTest
@testable import Market

class ItemsPresenterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddItemToCart() {
        let itemsPresenterDelegate = MockItemPresenterDelegate()
        
        let presenter = ItemsPresenter()
        presenter.delegate = itemsPresenterDelegate
        
        let currency = Currency("USD", exchangeRate: 1.0, currencyExchange: "USD")
        let item = Item("Peas", price: 1.3, currency: currency, quantity: "bag", imageURL: "")
        let item2 = Item("Milk", price: 2, currency: currency, quantity: "bottle", imageURL: "")
        
        presenter.addItemToCart(item)
        presenter.addItemToCart(item2)
        XCTAssert(presenter.getCartItems() != nil, "should have items")
        XCTAssert(presenter.getCartItems()!.count == 2, "should have two items in the cart")
        XCTAssert(itemsPresenterDelegate.updateCartItemsCalled, "should have called the delegate method")
    }
    
    func testItemsLoadedDelegateMethods() {
        let itemsPresenterDelegate = MockItemPresenterDelegate()
        
        let presenter = MockItemsPresenter()
        presenter.delegate = itemsPresenterDelegate
   
        presenter.getItems()
        
        XCTAssert(itemsPresenterDelegate.itemsLoadedCalled, "should have called the delegate method")
    }
}

class MockItemPresenterDelegate: ItemsPresenterDelegateProcol {
    var itemsLoadedCalled = false
    var updateCartItemsCalled = false
    
    func itemsLoaded() {
        itemsLoadedCalled = true
    }
    
    func updateCartItems(_ totalItems: Int) {
        updateCartItemsCalled = true
    }
}

class MockItemsPresenter: ItemsPresenter {
    
    func getItems() {
        setupItems()
    }
}
