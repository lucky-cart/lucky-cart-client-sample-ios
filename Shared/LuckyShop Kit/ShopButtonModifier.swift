//
//  ShopButtonModifier.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

struct ShopButtonModifier: ViewModifier {

    var color: Color = .blue
    
    func body(content: Content) -> some View {
        return content
            .buttonStyle(PlainButtonStyle())
            .fixedSize()
            .padding(6)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(3)
    }
    
}
