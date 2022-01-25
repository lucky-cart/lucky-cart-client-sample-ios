//
//  LuckyShop+Model.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation

class ShopItem: Identifiable, Hashable {
    
    static func == (lhs: ShopItem, rhs: ShopItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        id.hash(into:&hasher)
    }
    
    var id = UUID()
    var name: String
    var identifier: String
    var imageName: String?
    
    
    public init(name: String, identifier: String, imageName: String? = nil) {
        self.name = name
        self.identifier = identifier
        self.imageName = imageName
    }
    
}


class Customer {
    var id: String = UUID().uuidString
    var lastName: String
    var firstName: String
    var phone: String
    var eMail: String
    var address: String
    
    static let test = Customer(id: "customer1234",
                               firstName: "Janine",
                               lastName: "Lemaire",
                               phone: "0620222022",
                               eMail: "janine@gmail.com",
                               address: "7 rue Saint-Anne, 75002, Paris")
    
    public init(id: String, firstName: String, lastName: String, phone: String, eMail: String, address: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.eMail = eMail
        self.address = address
    }
}

class Order: Identifiable, ObservableObject {
    weak var cart: Cart?
    
    var id = UUID()
    var product: Product
    var quantity: Int {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(product: Product, quantity: Int, cart: Cart) {
        self.product = product
        self.quantity = quantity
        self.cart = cart
    }
    
    var totalPrice: Double {
        product.price * Double(quantity)
    }
    
    var totalPriceWithoutTax: Double {
        product.priceWithoutTax * Double(quantity)
    }
}

class Cart: ObservableObject {
    let id = UUID()
    
    static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "EU")
        formatter.currencySymbol = "€"
        return formatter
    }()
    
    @Published var productOrders = [Order]()
    
    @Published var totalNumberOfProducts: Int = 0
    
    @Published var paid: Bool = false
    
    var totalPriceString: String {
        return Cart.formatter.string(for: totalPrice) ?? "\(totalPrice)"
    }
    
    var totalPriceWithoutTaxesString: String {
        return Cart.formatter.string(for: totalPrice) ?? "\(totalPrice)"
    }
    
    var totalPrice: Double {
        return productOrders.reduce(0, { total, order in
            return total + order.totalPrice
        })
    }
    
    var totalPriceWithoutTax: Double {
        return productOrders.reduce(0, { total, order in
            return total + order.totalPriceWithoutTax
        })
    }
    
    func add(product: Product) {
        if let order = productOrders.first(where: {$0.product.identifier == product.identifier}) {
            order.quantity = order.quantity + 1
        } else {
            productOrders.append( Order(product: product, quantity: 1, cart: self) )
        }
        totalNumberOfProducts = productOrders.reduce(0, { sum, order in
            return sum + order.quantity
        })
    }
}

final class Product: ShopItem {
    var brand: Brand
    var price: Double
    var tax: Double = 0.2
    var priceWithoutTax: Double { price - (tax * price) }
    
    public init(name: String, identifier: String, imageName: String, brand: Brand, price: Double) {
        self.brand = brand
        self.price = price
        self.tax = 0.2
        super.init(name: name, identifier: identifier, imageName: imageName)
    }
    
    var priceString: String {
        return Cart.formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

final class Brand: ShopItem {
    
}

final class Category: ShopItem {
    
    var products: [Product]
    
    public init(name: String, identifier: String, imageName: String? = nil, products: [Product]) {
        self.products = products
        super.init(name: name, identifier: identifier, imageName: imageName)
    }
    
}


typealias Catalog = [Category]
