//
//  CheckoutPresenterTests.swift
//  Market
//
//  Created by rgonzalez on 6/5/17.
//  Copyright © 2017 RG. All rights reserved.
//

import XCTest
@testable import Market

class CheckoutPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTotalSum() {
        let presenter = CheckoutPresenter()
        var total: String = presenter.totalSum()
        XCTAssert(total == "0.00", "total should be 0.00")
        let currency = Currency("USD", exchangeRate: 1.0, currencyExchange: "USD")
        let item = Item("Peas", price: 1.3, currency: currency, quantity: "bag", imageURL: "")
        let item2 = Item("Milk", price: 1.7, currency: currency, quantity: "bottle", imageURL: "")
        presenter.items = [item,item2]
        
        total = presenter.totalSum(convertTo: nil)
        XCTAssert(total == "3.00", "total should be 3.00")
        
        total = presenter.totalSum(convertTo: currency)
        XCTAssert(total == "USD 3.00", "total should be USD 3.00")
    }
    
    func testPrice() {
        let presenter = CheckoutPresenter()
        var price = presenter.price(item: nil, convertTo: nil)
        XCTAssert(price == "0.00", "price should be 0.00")
        
        let currency = Currency("USD", exchangeRate: 1.0, currencyExchange: "USD")
        let currency2 = Currency("CUR", exchangeRate: 2, currencyExchange: "USD")
        let item = Item("Peas", price: 1.3, currency: currency, quantity: "bag", imageURL: "")
        
        price = presenter.price(item: item, convertTo: nil)
        XCTAssert(price == "1.30", "price should be 1.30")
        price = presenter.price(item: item, convertTo: currency2)
        XCTAssert(price == "CUR 2.60", "price should be CUR 2.60")
    }
}
