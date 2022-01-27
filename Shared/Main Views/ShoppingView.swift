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
    
    var bannerSpaceId: LCBannerSpaceIdentifier = LCBannerSpaceIdentifier("categories")
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var displayedCategories: [Category]
    
    @State var selectedCategory = Set([Category]())
    
    @State var numberOfProducts: Int = 0
    

    var body: some View {
        NavigationView {
            VStack {
                List(displayedCategories, selection: $selectedCategory) { category in
                    NavigationLink {
                        CategoryBrowser(category: category)
                    } label: {
                        CategoryView(item:category).frame(minWidth: 200, maxWidth: 1000, minHeight: 80, maxHeight: 120, alignment: .center)
                    }
                }
            }
            
            .navigationTitle("Lucky Shop")
        }
        .task {
            LuckyCart.shared.banner(with: "banner_100",
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
