//
//  CheckoutTableViewController.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/4/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate let currencyCellIdentifier = "CheckoutCellCurrencyIdentifier"
    fileprivate let itemsCellIdentifier = "CheckoutCellItemsIdentifier"
    fileprivate let showCurrencySegueIdentifier = "currencyPiker"
   
    let presenter = CheckoutPresenter()
    var currency: Currency? {
        didSet {
            tableView.reloadData()
        }
    }
}

//MARK - navigation
extension CheckoutTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showCurrencySegueIdentifier {
            let destination = segue.destination as? CurrencyPickerTableViewController
            destination?.delegate = self
            destination?.presenter.items = presenter.currencies
        }
    }
}

extension CheckoutTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellIdentifier, for: indexPath)
            
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("Select Currency", comment: "Select the currency for the prices of the items in the cart")
                cell.detailTextLabel?.text = currency?.name
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .default
            } else {
                cell.textLabel?.text = NSLocalizedString("Total", comment: "Total amount of the items in the cart")
                cell.detailTextLabel?.text = presenter.totalSum(convertTo: currency)
                
                cell.selectionStyle = .none
                cell.accessoryType = .none
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: itemsCellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        let item: Item? = presenter.item(at: indexPath)
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = presenter.price(item: item, convertTo: currency)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            performSegue(withIdentifier: showCurrencySegueIdentifier, sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension CheckoutTableViewController: CurrencyPickerTableViewControllerDelegate {
    func currencySelected(_ currency: Currency) {
        self.currency = currency
    }
}
