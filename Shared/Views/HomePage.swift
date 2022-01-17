//
//  WelcomeView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var shop: LuckyShop

    var action: (()->Void)?
    
    var body: some View {
        HStack {
        VStack {
            Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
            Text("Welcome")
            Button("Start Shopping") {
                action?()
            }
            .modifier(ShopButtonModifier(color: .green))
        }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
