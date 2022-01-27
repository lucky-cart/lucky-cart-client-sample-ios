//
//  BoutiqueView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 25/01/2022.
//

import SwiftUI
import LuckyCart

/// Displays a 'Boutique' view, that can be accessed by clicking a banner

struct BoutiqueView: View, LCBoutiqueView {
    
    @EnvironmentObject var shop: LuckyShop
    
    /// The view identifier that will be set in the action reference
    var boutiquePageIdentifier: String
    
    var action: (()->Void)?
    
    var brand: Brand { TestCatalog.coffeeBrothers }
    
    var products: [Product] {
        shop.catalog.products(with: brand)
    }
    
    @State var banners: [LCBanner] = []
    
    var body: some View {
        VStack {
            VStack {
                Text("Promotion").font(.title3).foregroundColor(.cyan)
                Text("\(brand.name)").font(.title).foregroundColor(.cyan)
            }
            List(products) { product in
                ProductView(item: product)
            }
            .listStyle(InsetListStyle())

            BoutiqueButtonsBarView(action: ("Continue Shopping", {
                action?()
            })).padding()
        }
        .navigationTitle(brand.name)
    }
}

struct BoutiqueView_Previews: PreviewProvider {
    static var previews: some View {
        BoutiqueView(boutiquePageIdentifier: "250").environmentObject(LuckyShop())
    }
}
