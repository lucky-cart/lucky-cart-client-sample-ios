//
//  LuckyShop.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation
import LuckyCart

typealias Order = LuckyShop.Order

class LuckyShop: ObservableObject, LuckyCartClient {
    
    var shopId = "2022_luckyshop"
    var currency: String = "EUR"
    
    /// The user customer data
    var customer: Customer = Customer.test
    
    /// Your catalog manager
    ///
    /// Returns the categories and products for the shop
    lazy var catalog: Catalog = TestCatalog.catalog
    
    /// Custom shop data example
    var luckyCoupon: String = ""
    
    /// Your cart manager
    ///
    /// Value is published, so UI can be refreshed when a new cart is set
    @Published var cart: Cart = Cart()
    
    /// Sample app can display different views.
    /// Currently displayed view identifier is set here.
    ///
    /// Value is published, so the UI can refresh accordingly
    @Published var selectedView: String = "homepage"
    
    
    /// Send a request to check out and wait for the result
    func checkOut(failure: @escaping (Error)->Void,
                  success: @escaping (LCPostCartResponse)->Void) {
        
        // Sample shop does not send any request, it simply marks the cart as paid
        LuckyCart.shared.checkOut(ticketComposer: ticketComposerForLuckyCart,
                                  failure: { error in
            DispatchQueue.main.async { self.aknowledgePayment() }
        }, success: { response in
            DispatchQueue.main.async { self.aknowledgePayment() }
        })
    }
    
    func aknowledgePayment() {
        self.cart.paid = true
    }
    
    init() {
        initLuckyCart()
    }
}
