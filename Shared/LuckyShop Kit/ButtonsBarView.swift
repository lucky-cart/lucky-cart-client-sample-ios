//
//  ActionsView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI

/// ButtonsBarView
///
/// This is the sample app toolbar view.
/// It contains the Login/Logout button and the number of products in the cart by default
/// An extra button can be configured by passing

struct ButtonsBarView: View {
    
    @EnvironmentObject var shop: LuckyShop

    @Binding var numberOfProducts: Int
    
    var action: (String, ((Bool)->Void)->Void)
    
    var body: some View {
        HStack {
                        
            LogInOutButton()
            Spacer()
            if numberOfProducts > 0 {
                VStack(alignment: .trailing) {
                    Text("\(numberOfProducts) Products").font(.caption)
                    Text("\(shop.cart.totalPriceString)").font(.caption)
                }
            } else {
                VStack(alignment: .trailing) {
                    Text("Add Products To Cart").opacity(0.7).font(.caption)
                    Button("Auto-Fill Cart and Check Out") {
                        shop.randomize()
                        shop.selectedView = "cart"
                    }.font(.caption2).multilineTextAlignment(.trailing)
                }
            }
            
            if numberOfProducts > 0 {
                Button(action.0) {
                    action.1() { result in
                        shop.selectedView = "cart"
                    }
                }.modifier(ShopButtonModifier(color: .green))
                    .font(.caption2)
            }
        }.padding(16).cornerRadius(8)
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsBarView(numberOfProducts: .constant(0), action: ("Test", { _ in })).environmentObject(LuckyShop())
    }
}
