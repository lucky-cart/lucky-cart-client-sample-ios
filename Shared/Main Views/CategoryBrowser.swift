//
//  ProductBrowser.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

struct CategoryBrowser: View {
    
    @EnvironmentObject var shop: LuckyShop

    @State var category: LuckyShop.Category
    
    var products: [LuckyShop.Product] {
        category.products
    }
    
    var body: some View {
        List(products) { product in
            ProductView(item: product)
        }
        .navigationTitle(category.name)
    }
}

struct ProductBrowser_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBrowser(category: TestCatalog.coffees)
    }
}
