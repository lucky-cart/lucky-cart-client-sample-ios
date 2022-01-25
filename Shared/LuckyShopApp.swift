//
//  Lucky_ShopApp.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI
import LuckyCart

@main
struct Lucky_ShopApp: App {
    
    /// luckyShop
    ///
    /// The LuckyShop manager, which control customer, cart and products catalog
    ///
    /// In this SwiftUI based sample, the shop is passed as an environment object 
    
    let luckyShop = LuckyShop()
    
    var body: some Scene {
        WindowGroup {
            withAnimation {
                ShopView(orders: []).environmentObject(luckyShop)
                    .modifier(LCDebugViewModifier())
#if os(macOS)
                    .frame(minWidth: 800, idealWidth: 800, maxWidth: 1200, minHeight: 600, idealHeight: 600, maxHeight: 800)
#endif
            }
        }
    }
}
