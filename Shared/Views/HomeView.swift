//
//  HomeView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var displayedCategories: [LuckyShop.Category]
    
    @State var selectedCategory = Set([LuckyShop.Category]())
    
    @State var numberOfProducts: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List(displayedCategories, selection: $selectedCategory) { category in
                    NavigationLink {
                        CategoryBrowser(category: category)
                    } label: {
                        CategoryView(item:category).frame(minWidth: 200, idealWidth: 300, maxWidth: 1000, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .center)
                    }
                    
                }
            }
            
            .navigationTitle("Lucky Shop")
        }
        
        ActionsView(numberOfProducts: $numberOfProducts, action: ("Check Out", { response in
            shop.selectedView = "cart"
        })).padding()
            .onReceive(shop.cart.$totalNumberOfProducts) { numberOfProducts in
                self.numberOfProducts = numberOfProducts
            }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let shop = LuckyShop()
        HomeView(displayedCategories: Array(shop.catalog)).environmentObject(shop)
    }
}
