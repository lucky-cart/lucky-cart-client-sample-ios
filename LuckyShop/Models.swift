//
//  Models.swift
//  LuckyShop
//
//  Created by Lucky Cart on 26/01/2023.
//

import Foundation
import UIKit
import LuckyCartSDK

class Customer {
    static let shared = Customer()
    
    var isLogged: Bool = false {
        didSet {
            LuckyCart.shared.setUser(identifier)
        }
    }
    var identifier: String {
        return isLogged ? "customer\(Int.random(in: 130 ... 12599))" : "unknown"
//        return isLogged ? "customer1234" : "unknown"
    }
}

class Shop {
    static let shared = Shop()
    
    var categories: [Category]?
}

struct Category {
    let id: String
    let title: String
    let image: UIImage
    let products: [Product]
}

struct Product {
    let id: String
    let title: String
    let image: UIImage
    let price: Double
    let categoryId: String
}

class Cart {
    
    static let shared = Cart()
    
    var cartId: String = "Cart01"
    var transactionDate: Date?
    var storeId: String?
    var storeTypeId: String?
    var currency: String?
    var device: String?
    var lang: String?
    var finalAtiAmount: Double {
        guard let products = products else { return 0.0 }
        
        var amount: Double = 0
        for product in products {
            amount += (product.finalAtiAmount ?? 0.0)
        }
        return amount
    }
    var finalTfAmount: Double {
        guard let products = products else { return 0.0 }
        
        var amount: Double = 0
        for product in products {
            amount += (product.finalTfAmount ?? 0.0)
        }
        return amount
    }
    var totalDiscountAtiAmount: Double {
        guard let products = products else { return 0.0 }
        
        var amount: Double = 0
        for product in products {
            amount += (product.discountAtiAmount ?? 0.0)
        }
        return amount
    }
    var totalDiscountTfAmount: Double {
        guard let products = products else { return 0.0 }
        
        var amount: Double = 0
        for product in products {
            amount += (product.discountTfAmount ?? 0.0)
        }
        return amount
    }
    var deliveryAtiAmount: Double?
    var deliveryTfAmount: Double?
    var deliveryMode: String?
    var deliveryDate: Date = Date()
    var paymentType: String?
    var promoCode: String?
    var promoCodeAtiAmount: Double?
    var promoCodeLabel: String?
    var loyaltyCard: String?
    var hasLoyaltyCard: Bool?
    var isNewShopper: Bool?
    var products: [CartProduct]?
}

class CartProduct {
    var productId: String?
    var unitAtiAmount: Double?
    var unitTfAmount: Double?
    var finalAtiAmount: Double?
    var finalTfAmount: Double?
    var discountAtiAmount: Double?
    var discountTfAmount: Double?
    var quantity: Int?
    var category: String?
    var brand: String?
    var ean: String?
    
    init(productId: String? = nil, unitAtiAmount: Double? = nil, unitTfAmount: Double? = nil, finalAtiAmount: Double? = nil, finalTfAmount: Double? = nil, discountAtiAmount: Double? = nil, discountTfAmount: Double? = nil, quantity: Int? = nil, category: String? = nil, brand: String? = nil, ean: String? = nil) {
        self.productId = productId
        self.unitAtiAmount = unitAtiAmount
        self.unitTfAmount = unitTfAmount
        self.finalAtiAmount = finalAtiAmount
        self.finalTfAmount = finalTfAmount
        self.discountAtiAmount = discountAtiAmount
        self.discountTfAmount = discountTfAmount
        self.quantity = quantity
        self.category = category
        self.brand = brand
        self.ean = ean
    }
    
    func update(newQuantity: Int, newFinalAtiAmount: Double) {
        finalAtiAmount = newFinalAtiAmount
        quantity = newQuantity
    }
}


extension Cart {
    
    func addProduct(_ product: Product) {
        
        if let existingProductIndex = products?.firstIndex(where: { inCartProduct in
            return inCartProduct.productId == product.id
        }) {
            let newQuantity = (products?[existingProductIndex].quantity ?? 0) + 1
            let newTotalPrice = (products?[existingProductIndex].finalAtiAmount ?? 0) + product.price
            products?[existingProductIndex].quantity = newQuantity
            products?[existingProductIndex].finalAtiAmount = newTotalPrice
        }
        else {
            if products == nil {
                products = []
            }
            products?.append(CartProduct(
                productId: product.id,
                unitAtiAmount: product.price,
                finalAtiAmount: product.price,
                quantity: 1,
                category: product.categoryId
            ))
        }
        NotificationCenter.default.post(name: NSNotification.Name("cartUpdatedNotification"),
                                        object: nil)
    }
    
    func removeProduct(_ product: CartProduct) {
        products?.removeAll(where: { cartProduct in
            return cartProduct.productId == product.productId
        })
        NotificationCenter.default.post(name: NSNotification.Name("cartUpdatedNotification"),
                                        object: nil)
    }
    
    func removeAllProducts() {
        products?.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name("cartUpdatedNotification"),
                                        object: nil)
    }
    
    func numberOfProducts() -> Int {
        guard let products = products,
              products.count > 0 else {
            return 0
        }
        var quantity = 0
        for product in products {
            quantity += product.quantity ?? 0
        }
        return quantity
    }
    
    func cartToLuckyCartPayload() -> LCEventPayload {
        var payload = LCEventPayload()
        payload.cartId = cartId
        payload.currency = "EUR"
        payload.device = "web-optin"
        payload.finalAtiAmount = finalAtiAmount
        payload.deliveryAtiAmount = 0.0
        payload.deliveryTfAmount = 0.0
        
        var payloadProducts: [LCEventPayloadProduct] = []
        
        if let products = products {
            for product in products {
                let p = LCEventPayloadProduct(productId: product.productId,
                                              unitAtiAmount: product.unitAtiAmount,
                                              unitTfAmount: product.unitTfAmount,
                                              finalAtiAmount: product.finalAtiAmount,
                                              finalTfAmount: product.finalTfAmount,
                                              discountAtiAmount: product.discountAtiAmount,
                                              discountTfAmount: product.discountTfAmount,
                                              quantity: product.quantity,
                                              category: product.category,
                                              brand: product.brand,
                                              ean: product.ean)
                payloadProducts.append(p)
            }
        }
        
        payload.products = payloadProducts
        
        return payload
    }
}
