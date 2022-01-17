//
//  LuckyShop.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import Foundation

typealias Order = LuckyShop.Order


class LuckyShop: ObservableObject {
    
    var currency: String = "EUR"
    
    /// The user customer data
    var customer: Customer = Customer.test
    
    @Published var cart: Cart = Cart()

    @Published var selectedView: String = "homepage"

    lazy var catalog: Catalog = TestCatalog.catalog
    
    /// There is chance that you will need to send a request to check out and wait for the result
    func checkOut(completion: ()->Void) {
        completion()
    }
}
