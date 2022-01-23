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
    
    /// metaDataForLuckyCart
    ///
    /// Returns the optional meta information to send to LuckyCart
    /// Meta are fully customizable by client.
    ///
    /// - returns: The customer ticket information `LCTicketComposer.Cart`

    var metaDataForLuckyCart: LCTicketComposer.MetaData {
        LCTicketComposer.MetaData(dictionary: [
            "luckyCoupon" : luckyCoupon
        ])
    }

    /// customerForLuckyCart
    ///
    /// Returns the customer optional information to send to LuckyCart
    /// - customer id in client database
    /// - customer email
    /// - customer first name
    /// - customer last name
    ///
    /// - returns: The customer ticket information `LCTicketComposer.Cart`
    
    var customerForLuckyCart: LCTicketComposer.Customer {
        LCTicketComposer.Customer(customerClientId: customer?.id.uuidString,
                                  email: customer?.eMail,
                                  firstName: customer?.firstName,
                                  lastName: customer?.lastName)
    }

    /// cartForLuckyCart
    ///
    /// Returns the cart information to send to LuckyCart
    /// - currency
    /// - cart id in client database
    /// - total price all tax included
    /// - total price without tax
    /// - products
    ///
    /// - returns: The cart ticket information `LCTicketComposer.Cart`

    var cartForLuckyCart: LCTicketComposer.Cart {
        LCTicketComposer.Cart(cartClientId: cart.id.uuidString,
                              currency: currency,
                              ttc: LCTicketComposer.priceString(cart.totalPrice),
                              ht: LCTicketComposer.priceString(cart.totalPriceWithoutTax),
                              products: productOrdersForLuckyCart)
    }

    /// orderForLuckyCart
    ///
    /// Returns the order information to send to LuckyCart
    /// - shop id
    /// - shipping method
    /// - device
    ///
    /// - returns: The order ticket information `LCTicketComposer.Order`

    var orderForLuckyCart: LCTicketComposer.Order {
        LCTicketComposer.Order(shippingMethod: .pickUp, shopId: shopId, device: "ios-sim")
    }
    
    /// productOrdersForLuckyCart
    /// Returns the product orders information formatted for LuckyCart
    ///
    /// - returns: An array of product orders - `[LCTicketComposer.ProductOrder]`

    var productOrdersForLuckyCart: [LCTicketComposer.ProductOrder] {
        cart.productOrders.map { order in
            LCTicketComposer.ProductOrder(id: order.id.uuidString,
                                          quantity: "\(order.quantity)",
                                          ttc: LCTicketComposer.priceString(order.totalPrice),
                                          ht: LCTicketComposer.priceString(order.totalPriceWithoutTax))
        }
    }
}

// MARK: - Custom LuckyShop/LuckyCart utilities

extension LuckyShop {
    
    /// Returns the banner identifier for a given product
    func bannerIdentifier(for product: Product) -> LCBannerIdentifier? {
        switch product.identifier {
            case "ristretto":
                return "banner_100"
        default:
            return nil
        }
    }

}
