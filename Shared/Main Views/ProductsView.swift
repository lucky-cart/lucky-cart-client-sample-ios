//
//  ProductBrowser.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI
import LuckyCart

struct BrowserItem: Identifiable {
    let id = UUID()
    var product: Product?
    var bannerId: String?
    var banner: LCBanner?
}

struct ProductsView: View {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var category: Category
    
    var products: [Product] {
        category.products
    }
    
    var items: [BrowserItem] {
        var out = [BrowserItem]()
        products.forEach { product in
            out.append(BrowserItem(product: product, bannerId: nil))
            
            //if we should display a banner here, we do
            if let bannerId = bannerIdentifier(for: product.identifier) {
                out.append(BrowserItem(product: nil, bannerId: bannerId))
            }
        }
        return out
    }
    
    /// In this example, we choose to display a promotional banners
    /// for two different coffee brands
    func bannerIdentifier(for productId: String?) -> String? {
        guard let id = productId else { return nil }
        switch id {
        case "ristretto":
            return "100"
        case "blue_mountain":
            return "200"
        default:
            return nil
        }
    }
    
    var body: some View {
        // Either display a product or a banner
        List(items) { item in
            if let product = item.product {
                ProductView(item: product)
            } else {
                LCAsyncSimpleBannerView(bannerSpaceId: LuckyShop.categories,
                                        bannerId: item.bannerId!,
                                        format: LuckyShop.bannerFormat)
            }
        }
        .listStyle(InsetListStyle())
        .navigationTitle(category.name)
    }
}

struct ProductBrowser_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: TestCatalog.coffees)
    }
}
