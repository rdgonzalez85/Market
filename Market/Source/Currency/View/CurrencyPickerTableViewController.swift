//
//  CurrencyPickerTableViewController.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/4/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

protocol CurrencyPickerTableViewControllerDelegate {
    func currencySelected(_ currency: Currency)
}

class CurrencyPickerTableViewController: UITableViewController {

    
    let presenter = CurrencyPickerPresenter()
    
    var delegate: CurrencyPickerTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let cellIdentifier = "CurrencyPickerCellIdentifier"
}

extension CurrencyPickerTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        guard let item: Currency = presenter.item(at: indexPath) else {
            return cell
        }

        cell.detailTextLabel?.text = presenter.currencyValue(currency: item)
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem: Currency = presenter.item(at: indexPath) {
            delegate?.currencySelected(selectedItem)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
