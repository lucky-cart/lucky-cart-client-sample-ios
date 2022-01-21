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
    
    func initLuckyCart() {
        _ = LuckyCart(authorization: LuckyCart.testAuthorization,
                      customer: LuckyCart.testCustomer,
                      cart: LCCart())
    }
    
    // Add any extra information here
    var metaDataForLuckyCart: LCTicketComposer.MetaData {
        LCTicketComposer.MetaData(dictionary: [
            "luckyCoupon" : luckyCoupon
        ])
    }
    
    
    
    var customerForLuckyCart: LCTicketComposer.Customer {
        LCTicketComposer.Customer(customerClientId: customer.id.uuidString,
                                  email: customer.eMail,
                                  firstName: customer.firstName,
                                  lastName: customer.lastName)
    }
    
    var cartForLuckyCart: LCTicketComposer.Cart {
        LCTicketComposer.Cart(cartClientId: cart.id.uuidString,
                              currency: currency,
                              ttc: LCTicketComposer.priceString(cart.totalPrice),
                              ht: LCTicketComposer.priceString(cart.totalPriceWithoutTax),
                              products: productOrdersForLuckyCart)
    }
    
    var orderForLuckyCart: LCTicketComposer.Order {
        LCTicketComposer.Order(shippingMethod: .pickUp, shopId: shopId, device: "ios-sim")
    }
    
    var productOrdersForLuckyCart: [LCTicketComposer.ProductOrder] {
        cart.productOrders.map { order in
            LCTicketComposer.ProductOrder(id: order.id.uuidString,
                                          quantity: "\(order.quantity)",
                                          ttc: LCTicketComposer.priceString(order.totalPrice),
                                          ht: LCTicketComposer.priceString(order.totalPriceWithoutTax))
        }
    }
}
