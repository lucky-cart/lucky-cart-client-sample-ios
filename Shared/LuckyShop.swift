//
//  LuckyShop.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation
import LuckyCart

/// LuckyShop is a shop manager example that demonstrates how to integrate LuckyCart with a native shopping application.
///
/// LuckyShop covers the primitive needs of any shopping application.
///
/// It is defined by:
/// - a catalog (`Catalog`) that holds a dictionary of products (`Product`) keyed by categories (Category).
/// - a customer (`Customer`) that holds current customer information
/// - a cart (`Cart`) that manages the current order
///
/// This covers the main entities and functions any online shop is expected to have, more or less.

class LuckyShop: ObservableObject, LuckyCartClient {
    
    var shopId = "2022_luckyshop"
    
    var currency: String = "EUR"
    
    /// The current customer
    ///
    /// When the current customer currently browsing the shop changes,
    /// we also set the current LuckyCart share instance customer id property.
    
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
    
    // MARK: - Shop Functions
    
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
    }
    
    /// The check out request - in this sample, there is no network call. We simply call the success closure.
    ///
    /// In the real world, you probably need to send a request.
    
    func sendCart(cartId: String, failure: @escaping (Error) -> Void, success: @escaping (Any?) -> Void) {
        do {
            let ticket = try luckyCartTicket(cartId: cart.id.uuidString)
            
            // Execute your checkout request here
            // Then proceed to LuckCart checkOut
            
            LuckyCart.shared.sendCart(cartId: cartId,
                                      ticketComposer: ticket,
                                      failure: failure) { postCartResponse in
                success(postCartResponse)
            }
        }
        catch {
            failure(error)
        }
    }
    
    /// When the cart is paid
    ///
    /// Sets the paid property to true. Cart being published, the app will be able to subscribe to the change
    /// and update accordingly
    
    func aknowledgePayment() {
        
        self.cart.paid = true
    }
    
    /// randomize
    ///
    /// This function is for debugging purpose, to have a filled cart in one-click
    
    func randomize() {
        func r(_ max: Int) -> Int { return 1 + Int(arc4random()) % max }
        let cart = Cart()
        // Add some random products
        for _ in 0 ..< r(10) {
            let cat = catalog[r(catalog.count - 1)]
            let prod = cat.products[r(cat.products.count - 1)]
            cart.add(product: prod)
        }
        self.cart = cart
    }
}
