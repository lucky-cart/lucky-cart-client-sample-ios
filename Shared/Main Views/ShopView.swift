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

protocol LCActionListener {
    func handleBannerAction(action: LCBannerAction)
}

extension LCActionListener {
    
    func listenLuckyCartActions() {
        NotificationCenter.default.addObserver(forName: .bannerAction, object: nil, queue: nil) { notif in
            guard let dictionary = notif.userInfo as? [String: LCBannerAction],
                  let action = dictionary[LCBannerAction.Keys.action] else {
                      return
                  }
            handleBannerAction(action: action)
        }
    }
}

struct ShopView: View, LCActionListener {
    
    enum Page {
        case homepage
        case shopping
        case paid(cartId: String)
        case boutique(identifier: LCBoutiqueViewIdentifier)
    }
    
    @EnvironmentObject var shop: LuckyShop
    
    var displayedCategories: [Category] {
        return Array(shop.catalog)
    }
    
    @State var orders = [Order]()
    
    @State var selectedTab: String = "browser"
    
    @State var page: Page = .homepage
    
    @State var customerId: String? = LuckyCart.shared.customer.id
    
    func handleBannerAction(action: LCBannerAction) {
        switch action.type {
        case .boutique:
            page = .boutique(identifier: LCBoutiqueViewIdentifier(action.ref))
            break
        default:
            return
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                LogInOutButton().scaleEffect(CGSize(width: 0.9, height: 0.9))
                Spacer()
                Text("LuckyCart Customer : \(LuckyCart.shared.customer.id)").font(.caption)
                Spacer()
                Button {
                    page = .homepage
                } label: {
                    Label("", systemImage: "house.fill")
                }
                .scaleEffect(CGSize(width: 0.9, height: 0.9))
                
            }
            switch page {
                
                // MARK: - Homepage / Welcome
                
            case .homepage:
                HomePageView() {
                    shop.newCart()
                    page = .shopping
                    selectedTab = "browser"
                }
                
                // MARK: - Boutique View
                
            case .boutique(let targetId):
                BoutiqueView(boutiquePageIdentifier: targetId) {
                    page = .shopping
                }
                
                // MARK: - Paid View ( Succesful checkout )
                
            case .paid(let cartId):
                CartPaidView(cartId: cartId) {
                    page = .homepage
                }
                
                // MARK: - Shopping view ( Tabbed view Browse/Cart )
                
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
                self.page = .paid(cartId: shop.cart.id.uuidString)
            }
        }
        .onReceive(shop.$selectedView) { identifier in
            selectedTab = identifier
        }
        .onReceive(shop.$cart) { cart in
            orders = cart.productOrders
        }
        .onReceive(shop.$customer) { cart in
            customerId = shop.customer?.id
        }
        
        // MARK: - Start to listen to banner actions notifications when the view appears -->
        
        .onAppear() {
            listenLuckyCartActions()
        }
        .padding()
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(orders: []).environmentObject(LuckyShop())
    }
}
