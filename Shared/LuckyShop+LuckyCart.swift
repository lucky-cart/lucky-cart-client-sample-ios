//
//  LuckyShop+LuckyCart.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import Foundation
import LuckyCart

/// LuckyShop + LuckyCartClient
///
/// Converts the shop entities into lucky cart ticket

extension LuckyShop {
    
    /// initLuckyCart
    ///
    /// Initialize LuckyCart with the shop authorization.
    
    func initLuckyCart() {
        LuckyCart(authorization: LuckyCart.testAuthorization)
    }
    
    /// luckyCartTicket
    ///
    /// Returns the checkout tickect composer for LuckyCart.
    /// Once checkout is proceeded, create a `LCTicketComposer` object
    /// by passing the following objects and properties:
    /// - customer : *id, first name, last name, email
    /// - cart: *id, currency, ttc, ht
    /// - products: Array of products : *id, quantity, ttc, ht
    /// - order: shippingMethod, shopId, device
    /// - metaData : A free json dictionary

    func luckyCartTicket(cartId: String) throws -> LCTicketComposer {
        
        let meta = LCTicketComposer.MetaData(dictionary: [
            "luckyCoupon" : luckyCoupon
        ])
        
        let customer = LCTicketComposer.Customer(id: customer?.id.uuidString,
                                                 email: customer?.eMail,
                                                 firstName: customer?.firstName,
                                                 lastName: customer?.lastName)
        
        let productOrders: [LCTicketComposer.ProductOrder] =
        cart.productOrders.map { order in
            LCTicketComposer.ProductOrder(id: order.id.uuidString,
                                          quantity: "\(order.quantity)",
                                          ttc: LCTicketComposer.priceString(order.totalPrice),
                                          ht: LCTicketComposer.priceString(order.totalPriceWithoutTax))
        }
        
        let cart = LCTicketComposer.Cart(id: cart.id.uuidString,
                                         currency: currency,
                                         ttc: LCTicketComposer.priceString(cart.totalPrice),
                                         ht: LCTicketComposer.priceString(cart.totalPriceWithoutTax),
                                         products: productOrders)
        
        let order = LCTicketComposer.Order(shippingMethod: .pickUp, shopId: shopId, device: "ios-sim")
        
        
        return LCTicketComposer(customer: customer, cart: cart, order: order, metaData: meta)
    }
}
