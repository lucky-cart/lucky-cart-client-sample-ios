//
//  HeaderView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 27/01/2022.
//

import SwiftUI
import LuckyCart

struct HeaderView: View {
    
    @Binding var page: Page
    
    @State var customerName: String = "\(LuckyCart.shared.customer.id)"
    
    var body: some View {
        HStack {
            LogInOutButton().scaleEffect(CGSize(width: 0.9, height: 0.9)).padding(8)
            Spacer()
            VStack(alignment: .trailing) {
                Text("LuckyCart Customer").font(.system(size: 8))
                Text("\(LuckyCart.shared.customer.id)").font(.caption).bold()
            }.padding(8)
            Button {
                page = .homepage
            } label: {
                Label("", systemImage: "house.fill")
            }.padding(8)
            .scaleEffect(CGSize(width: 0.9, height: 0.9))
            .onChange(of: page) { page in
                self.page = page
            }
        }.background(.gray.opacity(0.5)).cornerRadius(6)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(page: .constant(.homepage))
    }
}
