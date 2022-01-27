//
//  ShopItemView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

/// A view that displays a generic shop item ( name and image )
struct CategoryView: View {
    
    @State var item: ShopItem
    
    var body: some View {
        if let imageName = item.imageName {
            Image(imageName).resizable().scaledToFill()
                .frame(minWidth: 200, maxWidth: 1000, minHeight: 40, maxHeight: 70, alignment: .center)
                .padding([.top,.bottom], 16)

        }
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(item: Brand(name:"Test Item", identifier: "testItem"))
    }
}
