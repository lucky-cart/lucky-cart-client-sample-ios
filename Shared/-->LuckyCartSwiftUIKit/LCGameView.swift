//
//  LCGameView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 18/01/2022.
//

import SwiftUI
import LuckyCart

struct LCGameView: View {
    @State var game: LCGame
    
    var body: some View {
        LCLinkView(link: game.mobileLink, placeHolder: Image("luckyCartGame"))
    }
}

#if DEBUG
struct LCGameView_Previews: PreviewProvider {
    static var previews: some View {
        LCGameView(game: LuckyCart.testGame)
    }
}
#endif
