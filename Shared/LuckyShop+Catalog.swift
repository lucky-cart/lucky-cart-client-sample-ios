//
//  LuckyShop+Catalog.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation
import LuckyCart

    
struct TestCatalog {
    // Brands
    static let coffeeBrothers = LuckyShop.Brand(name: "Coffee Brothers", identifier: "coffee_brothers")
    static let queensBeverages = LuckyShop.Brand(name: "Queens Beverage", identifier: "queens_beverage")
    
    static let locoBananas = LuckyShop.Brand(name: "Loco Bananas", identifier: "loco_bananas")
    static let bringYaFruit = LuckyShop.Brand(name: "Bring Ya Fruit", identifier: "bring_ya_fruit")

    // Products Categories
    static let coffees = LuckyShop.Category(name: "Coffees", identifier: "coffees", imageName: "coffees", products: [
        LuckyShop.Product(name: "Ristretto", identifier: "ristretto", imageName: "coffee", brand: coffeeBrothers, price: 3.90),
        LuckyShop.Product(name: "Classic", identifier: "classic", imageName: "coffee", brand: coffeeBrothers, price: 2.95),
        LuckyShop.Product(name: "Blue Mountain", identifier: "blue_mountain", imageName: "coffee2", brand: queensBeverages, price: 4.95),
        LuckyShop.Product(name: "Costa Rica", identifier: "costa_rica", imageName: "coffee2", brand: queensBeverages, price: 4.45)
    ])
    
    static let fruits = LuckyShop.Category(name: "Fruits", identifier: "fruits", imageName: "fruits", products: [
        LuckyShop.Product(name: "Bananas", identifier: "bananas", imageName: "bananas", brand: locoBananas, price: 1.70),
        LuckyShop.Product(name: "Coconut", identifier: "coconut", imageName: "coconut", brand: locoBananas, price: 2.85),
        
        LuckyShop.Product(name: "Red Apple", identifier: "apple.red", imageName: "apple.red", brand: bringYaFruit, price: 4.95),
        LuckyShop.Product(name: "Green Apple", identifier: "apple.green", imageName: "apple.green", brand: bringYaFruit, price: 4.45)
    ])
    
    static var catalog: [LuckyShop.Category] {
        return [
            TestCatalog.coffees,
            TestCatalog.fruits
        ]
    }
}

extension Array where Element == LuckyShop.Category {
    func product(with identifier: String) -> LuckyShop.Product? {
        for category in self {
            if let product = category.products.first(where:{$0.identifier == identifier}) {
                return product
            }
        }
        return nil
    }
}
