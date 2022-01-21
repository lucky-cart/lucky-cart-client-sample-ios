//
//  ActionsView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI

struct ActionsView: View {
    
    @EnvironmentObject var shop: LuckyShop

    @Binding var numberOfProducts: Int
    
    var action: (String, ((Bool)->Void)->Void)
    
    var body: some View {
        HStack {
                        
            LogInOutButton()
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts) Products").font(.caption)
            } else {
                Text("Add Products To Cart").opacity(0.7).font(.caption)
            }
            
            if numberOfProducts > 0 {
                Button(action.0) {
                    action.1() { result in
                        shop.selectedView = "cart"
                    }
                }.modifier(ShopButtonModifier(color: .green))
            }
        }.padding(16).cornerRadius(8)
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView(numberOfProducts: .constant(0), action: ("Test", { _ in })).environmentObject(LuckyShop())
    }
}
