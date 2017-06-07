//
//  ItemsTableViewCell.swift
//  Market
//
//  Created by Rodrigo Gonzalez on 6/3/17.
//  Copyright © 2017 RG. All rights reserved.
//

import UIKit
import SDWebImage

protocol ItemsTableViewCellDelegate: NSObjectProtocol {
    func addToCartSelected(_ item: Item)
}

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    weak var delegate: ItemsTableViewCellDelegate?
    
    fileprivate var item: Item?
    
    @IBAction func addToCartTapped(_ sender: Any) {
        guard item != nil else {
            return
        }
        delegate?.addToCartSelected(item!)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(_ item: Item) {
        self.item = item
        itemTitle.text = item.name
        itemPrice.text = item.priceString()
        itemQuantity.text = "per " + item.quantity
        
        itemImage.sd_setShowActivityIndicatorView(true)
        itemImage.sd_setIndicatorStyle(.gray)
        itemImage.sd_setImage(with: URL(string: item.imageURL), placeholderImage: UIImage(named: "placeholder"))
    }
}
