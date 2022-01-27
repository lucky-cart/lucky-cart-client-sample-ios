//
//  LogoView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 27/01/2022.
//

import SwiftUI
import LuckyCart

struct LogoView: View {
    
    @State var message: String = "Welcome"
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
        Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
                .shadow(radius: 6).clipShape(RoundedRectangle(cornerRadius: 12))
        Text(message).font(.title).foregroundColor(.blue)
        }.padding(16)
    }
}

#if DEBUG
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(page: .constant(.homepage))
    }
}
#endif
