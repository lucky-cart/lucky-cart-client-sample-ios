//
//  CartProductCell.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit

class CartProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTotalPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    var product: CartProduct? {
        didSet {
            guard let product = product else { return }
            
            let catalogProduct = Shop.shared.categories?.first { $0.id == product.category }?.products.first { $0.id == product.productId }
            
            productImageView.image = catalogProduct?.image
            productNameLabel.text = catalogProduct?.title
            productTotalPriceLabel.text = product.finalAtiAmount?.toPrice()
            productQuantityLabel.text = "Quantity : \(product.quantity ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productNameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        productTotalPriceLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .heavy)
        productTotalPriceLabel.textColor = .orange
        productQuantityLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    }
    
    @IBAction func didTapDeleteProduct(_ sender: Any) {
        guard let product = product else { return }
        Cart.shared.removeProduct(product)
    }
    
}
