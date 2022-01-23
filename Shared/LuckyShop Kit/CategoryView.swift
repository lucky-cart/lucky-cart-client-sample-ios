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
        ZStack {
            if let imageName = item.imageName {
                Image(imageName)
            }
            Text(item.name).font(.title).bold().fixedSize().foregroundColor(.white)
        }
        //.frame(minHeight: 80, idealHeight: 80, maxHeight: 80, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(item: Brand(name:"Test Item", identifier: "testItem"))
    }
}
