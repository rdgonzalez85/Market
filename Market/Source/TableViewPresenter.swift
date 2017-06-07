//
//  TableViewPresenter.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/4/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

protocol TableViewPresentableItemProtocol {
    var name: String { get }
}

protocol TableViewPresenterProtocol {
    var items: [TableViewPresentableItemProtocol]? { get set }
    var sectionItems: [Int] {get set}
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func item<T: TableViewPresentableItemProtocol>(at indexPath: IndexPath) -> T?
}

extension TableViewPresenterProtocol {

    func numberOfSections() -> Int {
        let hasItems = items != nil && items!.count > 0
        return hasItems ? sectionItems.count : 0
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sectionItems[section]
    }
    
    func item<T: TableViewPresentableItemProtocol>(at indexPath: IndexPath) -> T? {
        if sectionItems.count > 1 && indexPath.section == 0 {
            return nil
        }
        
        return items?[indexPath.row] as? T
    }
}
