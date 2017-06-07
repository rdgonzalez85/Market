//
//  CurrencyPickerPresenter.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/4/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

class CurrencyPickerPresenter: TableViewPresenterProtocol {
    var sectionItems = [Int]()
    
    internal var items: [TableViewPresentableItemProtocol]? {
        didSet {
            if let itemsCount = items?.count {
                sectionItems = [itemsCount]
            }
        }
    }

    fileprivate let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        
        return formatter
    }()
    
    func currencyValue(currency: Currency) -> String {
        return String(format: "%@ %@", currency.name, formatter.string(from: NSNumber(value:currency.exchangeRate)) ?? "0.0")
    }
}
