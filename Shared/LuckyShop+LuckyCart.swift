//
//  LuckyShop+LuckyCart.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import Foundation
import LuckyCart

/// Keys for the data sent int the sendCart request
struct Keys {
    // Customer
    static let lastName = "lastName"
    static let firstName = "firstName"
    static let email = "email"
    // Cart
    static let totalAti = "totalAti"
    static let currency = "currency"
    static let products = "products"
    static let loyaltyCart = "loyaltyCart"
    // Product
    static let quantity = "quantity"
    static let id = "id"
    static let ht = "ht"
    static let ttc = "ttc"
    // Order
    static let shopId = "shopId"
    static let shippingMethod = "shippingMethod"
    static let device = "device"
}


/// LuckyShop + LuckyCartClient
///
/// Converts the shop entities into lucky cart ticket

extension LuckyShop {
    
    public static let homepage = "homepage"
    public static let categories = "categories"
    
    public static let homePageBanner = ""
    public static let bannerFormat = "banner"
    
    public static let boutique = "boutique"
    
    /// initLuckyCart
    ///
    /// Initialize LuckyCart with the shop authorization.
    
    func initLuckyCart() {
        LuckyCart(authorization: LuckyCart.testAuthorization)
    }
    
    /// luckyCartTicket
    ///
    /// Returns the sendCart json composer for LuckyCart.
    /// Once checkout is proceeded, create a `LCTicketComposer` object
    /// by aggregating the following object properties:
    /// - customer : *first name, last name, email
    /// - cart: *currency, ttc, ht
    /// - products: Array of products : *id, quantity, ttc, ht
    /// - order: shippingMethod, shopId, device
    /// - metaData : A free json dictionary
    
    func luckyCartTicket(cartId: String) throws -> LCTicketComposer {
        
        // Make the array of product json dictionaries
        let productComposers = cart.productOrders.map { order in
            [
                Keys.id: order.id.uuidString,
                Keys.quantity: "\(order.quantity)",
                Keys.ttc: LuckyCart.priceString(order.totalPrice),
                Keys.ht: LuckyCart.priceString(order.totalPriceWithoutTax)
            ]
        }
        
        // Returns full json composer
        return LCDictionaryComposer(dictionary: [
            Keys.loyaltyCart: "myLoyaltyCart",
            
            Keys.email: customer?.eMail,
            Keys.firstName: customer?.firstName,
            Keys.lastName: customer?.lastName,
            
            Keys.shippingMethod: "pickUp",
            Keys.shopId: shopId,
            Keys.device: "ios-sim",
            
            Keys.currency: currency,
            Keys.ttc: LuckyCart.priceString(cart.totalPrice),
            Keys.ht: LuckyCart.priceString(cart.totalPriceWithoutTax),
            Keys.products : productComposers
        ])
    }
}
