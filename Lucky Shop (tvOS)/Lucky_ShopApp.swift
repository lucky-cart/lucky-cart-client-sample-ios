//
//  Lucky_ShopApp.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 24/01/2022.
//

import SwiftUI
import LuckyCart

@main
struct Lucky_ShopApp: App {
    
    // Your shop manager
    let luckyShop = LuckyShop()

    var body: some Scene {
        WindowGroup {
            ShopView(orders: []).environmentObject(luckyShop)
            .modifier(LCDebugLensModifier())
        }
    }
}
