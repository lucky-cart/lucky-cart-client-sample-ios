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
        Button() {
            if shop.loggedIn {
                shop.logout()
            } else {
                shop.login()
            }
        } label: {
            Label(shop.loggedIn ? "Log Out" : "Log In",
                  systemImage: shop.loggedIn ? "person.crop.circle.fill.badge.checkmark"
                  : "person.crop.circle.badge.xmark")
        }
        .foregroundColor(shop.loggedIn ? .red : .blue)
    }
}

struct LogInOutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInOutButton()
    }
}
