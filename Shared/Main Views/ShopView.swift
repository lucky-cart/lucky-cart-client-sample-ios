//
//  ContentView.swift
//  Shared
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI
import LuckyCart

// We use LuckyCart provided button style for the sample app
typealias ShopButtonModifier = LCButtonModifier

#if DEBUG

struct ShopButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test") {
            print("Test Tapped")
        }.modifier(ShopButtonModifier())
    }
}

#endif


struct ShopView: View {
    
    enum Page {
        case homepage
        case shopping
        case paid
    }
    
    @EnvironmentObject var shop: LuckyShop
    
    var displayedCategories: [LuckyShop.Category] {
        return Array(shop.catalog)
    }
    
    @State var orders = [LuckyShop.Order]()
    
    @State var selectedTab: String = "browser"
    
    @State var page: Page = .homepage
    
    @State var customerId: String? = LuckyCart.shared.customer.id
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                Text("LuckyCart Customer : \(LuckyCart.shared.customer.id)").font(.caption)
            }
            switch page {
            case .homepage:
                HomePageView() {
                    shop.newCart()
                    page = .shopping
                    selectedTab = "browser"
                }
            case .paid:
                CartPaidView() {
                    page = .homepage
                }
                
            case .shopping:
                TabView(selection: $selectedTab) {
                    VStack {
                        ShoppingView(displayedCategories: displayedCategories)
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Browse")
                    }
                    .tag("browser")
                    
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
            if paid {
                self.page = .paid
            }
        }
        .onReceive(shop.$selectedView) { identifier in
            selectedTab = identifier
        }
        .onReceive(shop.$cart) { cart in
            orders = cart.productOrders
        }
        .onReceive(shop.$customer) { cart in
            customerId = shop.customer?.id.uuidString
        }
        .padding()
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(orders: []).environmentObject(LuckyShop())
    }
}
