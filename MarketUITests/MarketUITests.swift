//
//  MarketUITests.swift
//  MarketUITests
//
//  Created by rgonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import XCTest

class MarketUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddToCartItems() {
        let app = XCUIApplication()
        XCTAssert(app.navigationBars["Market.ItemsTableView"].buttons["cart"].isEnabled == false, "Checkout button should be disabled")
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Peas").buttons["Add to cart"].tap()
        XCTAssert(app.navigationBars["Market.ItemsTableView"].buttons["cart"].isEnabled == true, "Checkout button should be enabled")
        tablesQuery.cells.containing(.staticText, identifier:"Eggs").buttons["Add to cart"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Milk").buttons["Add to cart"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Beans").buttons["Add to cart"].tap()
        app.navigationBars["Market.ItemsTableView"].buttons["cart"].tap()
        
        XCTAssert(app.navigationBars["Checkout"].exists, "Checkout title should be displayed")
    }
    
    func testCheckoutListItems() {
        testAddToCartItems()
        let tablesQuery = XCUIApplication().tables
        XCTAssert(tablesQuery.cells.count == 6, "table should display 6 items")
    }
    
    func testSelectCurrency() {
        testAddToCartItems()
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["Select Currency"].tap()
        tablesQuery.staticTexts["AED"].tap()
        app.navigationBars["Market.CurrencyPickerTableView"].buttons["Checkout"].tap()
        
        let cell = tablesQuery.staticTexts["AED"]
        XCTAssert(cell.exists, "should have updated the currency")
        
    }
}
