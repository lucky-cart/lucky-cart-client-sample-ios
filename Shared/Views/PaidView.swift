//
//  PaidView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI

struct PaidView: View {
    
    @EnvironmentObject var shop: LuckyShop

    var body: some View {
        HStack {
        VStack {
            Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
            Text("Thanks for your purchase")
            Button("Shop Again") {
                shop.cart = LuckyShop.Cart()
            }
            .modifier(ShopButtonModifier(color: .green))
        }
        }
    }
}

struct PaidView_Previews: PreviewProvider {
    static var previews: some View {
        PaidView()
    }
}
