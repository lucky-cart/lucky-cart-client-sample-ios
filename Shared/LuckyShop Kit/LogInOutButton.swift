//
//  LogInOutButton.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 21/01/2022.
//

import SwiftUI

struct LogInOutButton: View {
    @EnvironmentObject var shop: LuckyShop
    
    var body: some View {
        Button(shop.loggedIn ? "Log Out" : "Log In") {
            if shop.loggedIn {
                shop.logout()
            } else {
                shop.login()
            }
        }
        .font(.caption)
        .modifier(ShopButtonModifier(color: shop.loggedIn ? .red : .blue))
    }
}

struct LogInOutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInOutButton()
    }
}
