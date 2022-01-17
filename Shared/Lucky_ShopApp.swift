//
//  Lucky_ShopApp.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

@main
struct Lucky_ShopApp: App {
    
    var body: some Scene {
        WindowGroup {
            ShopView(orders: []).environmentObject(LuckyShop())
                .padding()
            #if os(macOS)
                .frame(minWidth: 800, idealWidth: 800, maxWidth: 1200, minHeight: 600, idealHeight: 600, maxHeight: 800)
            #endif
        }
    }
}
