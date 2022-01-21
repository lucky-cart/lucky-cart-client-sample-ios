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
    ///
    /// It's the right place to set LuckyCart user id
    ///
    @Published var customer: Customer? {
        didSet {
            LuckyCart.shared.setUser(customer == nil ? nil : LuckyCart.testCustomer)
        }
    }
    
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
    
    var loggedIn: Bool {
        customer != nil
    }
    
    func login() {
        customer = Customer.test
    }
    
    func logout() {
        customer = nil
    }
    
    /// Your cart creation function
    ///
    /// The right place to initialise a LuckyCart cart
    func newCart() {
        cart = LuckyShop.Cart()
        LuckyCart.shared.newCart()
    }
    
    /// The check out request - in this sample, there is no network call.
    func checkOut(failure: @escaping (Error) -> Void, success: @escaping (Any?) -> Void) {
        
        // Execute your checkout request here
        // Then proceed to LuckCart checkOut
        
        LuckyCart.shared.checkOut(ticketComposer: ticketComposerForLuckyCart,
                                  failure: failure) { postCartResponse in
            success(postCartResponse)
        }
    }
    

    func aknowledgePayment() {
        self.cart.paid = true
    }
    
    /// Returns the banner identifier for a given product
    func bannerIdentifier(for product: Product) -> LCBannerIdentifier? {
        switch product.identifier {
            case "ristretto":
                return "banner_100"
        default:
            return nil
        }
    }
    
    init() {
        initLuckyCart()
    }
}
