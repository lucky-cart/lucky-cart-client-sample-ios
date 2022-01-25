//
//  WelcomeView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI
import LuckyCart

struct HomePageView: BannerSpaceView {
    var bannerSpaceId: LCBannerSpaceIdentifier = LuckyShop.homepage
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var banners: [LCBanner] = []
    
    var action: (()->Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 16) {
                Image("logo").resizable().frame(width: 160, height: 160, alignment: .center)
                Text("Welcome")
                
                List(banners) { banner in
                    LCSimpleBannerView(banner: banner)
                }
                HStack {
                    Button("Start Shopping") {
                        action?()
                    }
                    .modifier(ShopButtonModifier(color: .green))
                }
            }
        }.task {
            LuckyCart.shared.banner(with: LCBannerIdentifier("banner"),
                                    bannerSpaceIdentifier: bannerSpaceId,
                                    format: LuckyShop.bannerFormat,
                                    failure: { error in
            }) { banner in
                banners.append(banner)
            }
        }
    }
}

#if DEBUG

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(LuckyShop())
    }
}

#endif
