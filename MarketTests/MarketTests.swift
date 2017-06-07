//
//  MarketTests.swift
//  MarketTests
//
//  Created by rgonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import XCTest
@testable import Market

class MarketTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetCurrencies() {
        let currenciesExpectation = expectation(description: "Currencies Expectation")
        
        let currencyService = CurrencyService.instance
        currencyService.apiKey = Utils.apiKey()
        
        currencyService.getCurrencies { (currenciesResponse, error) in
        
            if let currencies = currenciesResponse {
                XCTAssertTrue(currencies.count > 0, "should have at least one element")
            } else {
                XCTFail("Should have currencies")
            }
            currenciesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetItems() {
        let itemsExpectation = expectation(description: "Items Expectation")
        
        ItemService.getItems { (itemsResponse, error) in
            if let items = itemsResponse {
                XCTAssertTrue(items.count > 0, "should have at least one element")
            } else {
                XCTFail("Should have currencies")
            }
            itemsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
