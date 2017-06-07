//
//  CheckoutPresenter.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/4/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

class CheckoutPresenter: TableViewPresenterProtocol {

    var currencies: [Currency]?
    var items: [TableViewPresentableItemProtocol]? {
        didSet {
            if let itemsCount = items?.count {
                sectionItems = [2,itemsCount]
            }
        }
    }
    
    var sectionItems = [Int]()

    init() {
        self.loadCurrencies(nil)
    }

    fileprivate enum PriceFormat: String {
        case WithCurrency = "%@ %.2f"
        case WithoutCurrency = "%.2f"
    }
    
    
    func totalSum() -> String {
        guard let items = items as? [Item] else {
            return String(format: PriceFormat.WithoutCurrency.rawValue, 0.0)
        }
        
        let total = items.reduce(0.0) {$0 + $1.price}
        return String(format: PriceFormat.WithoutCurrency.rawValue, total)
    }
    
    func totalSum(convertTo currency: Currency?) -> String {
        guard let currency = currency, let items = items as? [Item] else {
            return totalSum()
        }
        
        let total = items.reduce(0.0) {$0 + $1.price}
        return String(format: PriceFormat.WithCurrency.rawValue, currency.name, total * currency.exchangeRate)
    }
    
    func price(item: Item?, convertTo currency: Currency?) -> String {
        let itemPrice = item?.price ?? 0.0
        
        guard let currency = currency else {
            return String(format: PriceFormat.WithoutCurrency.rawValue, itemPrice)
        }
        
        return String(format: PriceFormat.WithCurrency.rawValue, currency.name, itemPrice * currency.exchangeRate)
    }
    
    func loadCurrencies(_ completitionHandler: ReturnBlock?) {
        let currencyService = CurrencyService.instance
        currencyService.getCurrencies { (currenciesResponse, error) in
            if let currencies = currenciesResponse?.sorted(by: { $0.name < $1.name} ) {
                self.currencies = currencies
                completitionHandler?(currencies,nil)
            }
            if error != nil {
                //show error
                completitionHandler?(nil,error)
            }
        }
    }
}
