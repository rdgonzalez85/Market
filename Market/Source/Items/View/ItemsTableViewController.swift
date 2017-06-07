//
//  ItemsTableViewController.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/2/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var checkoutButton: BadgedBarButtonItem!
    
    let presenter = ItemsPresenter()
    
    fileprivate let itemCellIdentifier = "itemCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        
        tableView.tableFooterView = UIView()
        setupBarButton()
    }

    private func setupBarButton() {
        checkoutButton.badgeProperties.backgroundColor = .red
        checkoutButton.badgeProperties.textColor = .white
        checkoutButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckout" {
            let destination = segue.destination as? CheckoutTableViewController
            destination?.currency = (presenter.items?.first as? Item)?.currency
            destination?.presenter.items = presenter.getCartItems()
        }
    }
}

extension ItemsTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? ItemsTableViewCell else {
            return UITableViewCell()
        }

        if let item: Item = presenter.item(at: indexPath)  {
            cell.setup(item)
            cell.delegate = self
        }
        
        return cell
    }
}

extension ItemsTableViewController: ItemsPresenterDelegateProcol {
    func updateCartItems(_ totalItems: Int) {
        if totalItems > 0 {
            checkoutButton.isEnabled = true
        }
        checkoutButton.badgeValue = totalItems
    }
    
    func itemsLoaded() {
        tableView.reloadData()
    }
}

extension ItemsTableViewController: ItemsTableViewCellDelegate {
    func addToCartSelected(_ item: Item) {
        presenter.addItemToCart(item)
    }
}
