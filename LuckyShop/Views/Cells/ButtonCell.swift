//
//  ButtonCell.swift
//  LuckyShop
//
//  Created by Lucky Cart on 28/01/2023.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var actionButton: UIButton!
    
    var title: String? {
        didSet {
            actionButton.setTitle(title, for: .normal)
        }
    }
    
    var closure: (()->())?
    
    @IBAction func didTapButton(_ sender: Any) {
        guard let closure = closure else { return }
        
        closure()
    }
}
