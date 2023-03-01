//
//  ProductCell.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product? {
        didSet {
            guard let product = product else { return }
            
            productImageView.image = product.image
            productNameLabel.text = product.title
            productPriceLabel.text = product.price.toPrice()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productNameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        productPriceLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .heavy)
        productPriceLabel.textColor = .orange
    }
    
    @IBAction func didTapAddToCartButton(_ sender: Any) {
        guard let product = product else { return }
        Cart.shared.addProduct(product)
    }
    
}
