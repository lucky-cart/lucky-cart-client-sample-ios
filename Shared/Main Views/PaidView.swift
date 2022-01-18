//
//  PaidView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI
import LuckyCart

struct PaidView: View, GamesView {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var games: [LCGame] = []
    
    var action: (()->Void)
    
    var body: some View {
        HStack {
            VStack {
                Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
                Text("Thanks for your purchase")
                Button("Shop Again") {
                    action()
                }
                .modifier(ShopButtonModifier(color: .green))
                
                List(games) { game in
                    LCGameView(game: game)
                    .frame(height: 80, alignment: .center)
                }
            }
        }
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
        PaidView() { }
    }
}
