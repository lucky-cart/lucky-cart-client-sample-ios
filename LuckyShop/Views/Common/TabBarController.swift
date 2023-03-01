//
//  TabBarController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCartBadge(_:)),
                                               name: NSNotification.Name("cartUpdatedNotification"),
                                               object: nil)
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .lightGray
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func updateCartBadge(_ notification: Notification) {
        guard let cartItem = tabBar.items?.last else { return }
        let productsInCart = Cart.shared.numberOfProducts()
        cartItem.badgeValue = productsInCart == 0 ? nil : "\(productsInCart)"
    }
}
