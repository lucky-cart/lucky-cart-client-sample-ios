//
//  TotalCartCell.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit

class TotalCartCell: UITableViewCell {

    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var finalAtiAmount: Double? {
        didSet {
            totalPriceLabel.text = finalAtiAmount?.toPrice()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
