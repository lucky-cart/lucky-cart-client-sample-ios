//
//  CategoryCell.swift
//  LuckyShop
//
//  Created by Lucky Cart on 26/01/2023.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var category: Category? {
        didSet {
            guard let category = category else { return }
            
            categoryImageView.image = category.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
