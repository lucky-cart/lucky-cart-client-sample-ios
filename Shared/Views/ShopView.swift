//
//  ContentView.swift
//  Shared
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var shop: LuckyShop
    
    var displayedCategories: [LuckyShop.Category] {
        return Array(shop.catalog)
    }
    
    @State var orders = [LuckyShop.Order]()
    @State var paid: Bool = false
    
    @State var selectedTab: String = "homepage"
    
    @State var welcome = true
    
    var body: some View {
        VStack {
            if welcome {
                WelcomeView() {
                    shop.cart = LuckyShop.Cart()
                    welcome = false
                }
            } else if paid {
                PaidView()
            } else {
                
                TabView(selection: $selectedTab) {
                    VStack {
                        HomeView(displayedCategories: displayedCategories)
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag("homepage")
                    
                    CartView(orders: shop.cart.productOrders)
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Cart")
                        }
                        .tag("cart")
                }
                
            }
        }
        .onReceive(shop.cart.$paid) { paid in
            self.paid = paid
        }
        .onReceive(shop.$selectedView) { identifier in
            selectedTab = identifier
        }
        .onReceive(shop.$cart) { cart in
            selectedTab = "homepage"
            paid = cart.paid
            orders = cart.productOrders
        }

    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(orders: []).environmentObject(LuckyShop())
    }
}
