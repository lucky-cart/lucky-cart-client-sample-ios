//
//  PaidView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI
import LuckyCart

struct CartPaidView: View, GamesView {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var games: [LCGame] = []
    
    var action: (()->Void)
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 8) {
                Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
                Text("Thanks for your purchase")
                Button("Shop Again") {
                    action()
                }
                .modifier(ShopButtonModifier(color: .green))
                
                List($games) { game in
                    LCGameView(game: game)
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 30, idealHeight: 240, maxHeight: 300)
                }
            }
        }
        // We subscribe to the LuckyCart shared instance to refresh view when games are loaded
        .onReceive(LuckyCart.shared.$games, perform: { games in
            self.games = games ?? []
        })
        .task {
            LuckyCart.shared.loadGames { _ in
                
            } success: { games in
                self.games = games
            }
        }
    }
}

struct PaidView_Previews: PreviewProvider {
    static var previews: some View {
        CartPaidView() { }
    }
}
