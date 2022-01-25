//
//  BoutiqueView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 25/01/2022.
//

import SwiftUI

import SwiftUI
import LuckyCart

/// Displays a 'Boutique' view, that can be accessed by clicking a banner

struct BoutiqueView: View, LCBoutiqueView {
    
    @EnvironmentObject var shop: LuckyShop
    
    /// The view identifier that will be set in the action reference
    var boutiquePageIdentifier: LCBoutiqueViewIdentifier
    
    var action: (()->Void)?
    
    var brand: Brand { TestCatalog.coffeeBrothers }
    
    var products: [Product] {
        shop.catalog.products(with: brand)
    }
    
    @State var banners: [LCBanner] = []
    
    var body: some View {
        VStack {
            Text("Promotion \(brand.name)").font(.title2)
            List(products) { product in
                ProductView(item: product)
            }
            BoutiqueButtonsBarView(action: ("Continue Shopping", {
                action?()
            })).padding()
        }
        .navigationTitle(brand.name)
    }
}


struct BoutiqueView_Previews: PreviewProvider {
    static var previews: some View {
        BoutiqueView(boutiquePageIdentifier: LCBoutiqueViewIdentifier("250")).environmentObject(LuckyShop())
    }
}
