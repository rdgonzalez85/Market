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
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    weak var delegate: ItemsTableViewCellDelegate?
    
    fileprivate var item: Item?
    
    @IBAction func addToCartTapped() {
        guard item != nil else {
            return
        }
        delegate?.addToCartSelected(item!)
    }
    
    private func setupButton() {
        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect: addToCartButton.bounds, cornerRadius:addToCartButton.frame.size.width/2).cgPath
        border.frame = addToCartButton.bounds
        border.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        addToCartButton.layer.addSublayer(border)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupButton()
    }
    
    func setup(_ item: Item) {
        self.item = item
        itemTitle.text = item.name
        itemPrice.text = item.priceString()
        
        itemImage.sd_setShowActivityIndicatorView(true)
        itemImage.sd_setIndicatorStyle(.gray)
        itemImage.sd_setImage(with: URL(string: item.imageURL), placeholderImage: UIImage(named: "placeholder"))
    }
}
