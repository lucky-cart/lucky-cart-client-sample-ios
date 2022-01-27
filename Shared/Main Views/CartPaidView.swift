//
//  PaidView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI
import LuckyCart

/// CartPaidView
///
/// The view that the sample app displays once the order is paid

struct CartPaidView: View, GamesView {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var games: [LCGame] = []
    
    @State var cartId: String
    
    var action: (()->Void)
    @State var timeStamp: Date = Date()
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 8) {
                Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
                Text("Thanks for your purchase")
                Button("Shop Again") {
                    action()
                }
                .modifier(ShopButtonModifier(color: .green))
                
                //MARK: - Display LuckyCart Games
                
                List($games) { game in
                    LCGameView(game: game)
                    .modifier(LCGameResultViewModifier(gameResult: game.gameResult.wrappedValue))
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: nil,
                           minHeight: 30, idealHeight: 240, maxHeight: 300)
                }
                
            }
        }
        
        //MARK: - Subscribe to LuckyCart games list to update UI when games are reloaded

        .onReceive(LuckyCart.shared.$games, perform: { games in
            self.games = games ?? []
            self.timeStamp = Date()
        })
        .task {
            
            //MARK: - Load LuckyCart games
            
            LuckyCart.shared.loadGames(cartId: cartId) { _ in
                
            } success: { games in
                self.games = games
            }
        }
    }
}

#if DEBUG

struct PaidView_Previews: PreviewProvider {
    static var previews: some View {
        CartPaidView(cartId: LuckyCart.testCart.id) { }
    }
}

#endif
