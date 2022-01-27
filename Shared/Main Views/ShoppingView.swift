//
//  HomeView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI
import LuckyCart

struct ShoppingView: View, LCBannersView {
    
    var banners: State<[LCBanner]> = State.init(initialValue: [])
    
    var bannerSpaceId: String = String("categories")
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var displayedCategories: [Category]
    
    @State var selectedCategory = Set([Category]())
    
    @State var numberOfProducts: Int = 0
    
    
    var body: some View {
        NavigationView {
            List(displayedCategories, selection: $selectedCategory) { category in
                NavigationLink {
                    ProductsView(category: category)
                } label: {
                    CategoryView(item:category)                        
                }
            }
            .listStyle(InsetListStyle())
        }
        
        .task {
            LuckyCart.shared.banner(with: "100",
                                    bannerSpaceIdentifier: bannerSpaceId,
                                    format: LuckyShop.bannerFormat,
                                    failure: { _ in })
            { banner in
                print("Received Banner : ---->\r\(banner)\r<-----\r")
            }
        }
        
        ShoppingButtonsBarView(numberOfProducts: $numberOfProducts, action: ("Check Out", { response in
            shop.selectedView = "cart"
        })).padding()
            .onReceive(shop.cart.$totalNumberOfProducts) { numberOfProducts in
                self.numberOfProducts = numberOfProducts
            }
    }
}

#if DEBUG

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        let shop = LuckyShop()
        ShoppingView(displayedCategories: Array(shop.catalog)).environmentObject(shop)
    }
}

#endif
