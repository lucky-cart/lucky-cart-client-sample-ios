//
//  CartView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var orders: [LuckyShop.Order]
    
    @State var numberOfProducts: Int = 0

    var body: some View {
        VStack {
            List(orders) { productOrder in
                HStack {
                    Text(productOrder.product.name)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 8) {
                        Text(productOrder.product.priceString)
                        Text("x\(Int(productOrder.quantity))")
                    }
                }
            }
            .navigationTitle("Cart")
            .onReceive(shop.cart.$productOrders) { orders in
                self.orders = orders
            }
            .onReceive(shop.$cart) { cart in
                self.orders = cart.productOrders
            }
            Spacer()
            
            HStack {
                Text("Total :")
                Spacer()
                let priceString = shop.cart.totalPriceString
                Text(priceString)
            }.padding()
        
        ActionsView(numberOfProducts: $numberOfProducts, action: ("Pay", { response in
            shop.checkOut { error in
                
            } success: { response in
                shop.cart.paid = true
            }

        })).padding()
            .onReceive(shop.cart.$totalNumberOfProducts) { numberOfProducts in
                self.numberOfProducts = numberOfProducts
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(orders: LuckyShop().cart.productOrders)
    }
}
