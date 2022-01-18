//
//  ContentView.swift
//  Shared
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI


public struct ShopButtonModifier: ViewModifier {

    var color: Color = .orange
    
    public func body(content: Content) -> some View {
            content
            .buttonStyle(PlainButtonStyle())
            .fixedSize()
            .padding(7)
            .frame(minWidth: 80)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(6)
    }
}

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
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            switch page {
            case .homepage:
                HomePageView() {
                    shop.cart = LuckyShop.Cart()
                    page = .shopping
                }
            case .paid:
                PaidView() {
                    shop.cart = LuckyShop.Cart()
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

    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(orders: []).environmentObject(LuckyShop())
    }
}
