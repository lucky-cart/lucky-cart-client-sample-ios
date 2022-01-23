//
//  LuckyShop.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation
import LuckyCart

/// LuckyShop is a sample applications that demonstrates how to integrate LuckyCart with a native shopping application.
///
/// Lucky shop has :
/// - a catalog (`Catalog`) that holds a dictionary of products (`Product`) keyed by categories (Category).
/// - a customer (`Customer`) that holds current customer information
/// - a cart (`Cart`) that manages the current order
///
/// This covers the main entities and functions any online shop is expected to have, more or less.

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

    // MARK: - Initialisation
    
    /// init
    ///
    /// Initialise your shop
    /// The right place to initialise LuckyCart
    
    init() {
        initLuckyCart()
    }

    // MARK: - Functions

    /// loggedIn
    ///
    /// - returns: True if a customer is set
    var loggedIn: Bool {
        customer != nil
    }
    
    /// login
    ///
    /// Connects the user to the shop server
    ///
    /// Note that in this example, the login function always succeed since it uses hardcoded test data
    /// In the real world, you will probably need to connect to your system
    func login() {
        customer = Customer.test
    }
    
    
    /// login
    ///
    /// Sets a nil user. ( current customer )
    func logout() {
        customer = nil
    }
    
    /// Your cart creation function
    ///
    /// The right place to initialise a LuckyCart cart
    func newCart() {
        cart = Cart()
        LuckyCart.shared.newCart()
    }
    
    /// The check out request - in this sample, there is no network call. We simply call the success closure.
    ///
    /// In the real world, you probably need to send a request.
    func checkOut(failure: @escaping (Error) -> Void, success: @escaping (Any?) -> Void) {
        
        // Execute your checkout request here
        // Then proceed to LuckCart checkOut
        
        LuckyCart.shared.checkOut(ticketComposer: ticketComposerForLuckyCart,
                                  failure: failure) { postCartResponse in
            success(postCartResponse)
        }
    }
    
    /// When the cart is paid
    ///
    ///
    func aknowledgePayment() {
        self.cart.paid = true
    }
    
}
