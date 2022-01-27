//
//  WelcomeView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 17/01/2022.
//

import SwiftUI
import LuckyCart

struct HomePageView: LCBannersView {
    
    // The banners array
    var banners: State<[LCBanner]> = State(initialValue: [])
    
    // BannerSpaceView
    var bannerSpaceId: String = LuckyShop.homepage
    
    var action: (()->Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 16) {
                
                // Logo and welcome message
                LogoView()
                
                // MARK: - Display the list of LuckyCart banners -->
                
                List(banners.wrappedValue) { banner in
                    LCSimpleBannerView(banner: banner)
                }.listStyle(InsetListStyle())
                
                
                // Displays a centered start button that call an action set by the ShopView ( Top container view )
                
                HStack {
                    Button("Start Shopping") {
                        action?()
                    }
                    .modifier(ShopButtonModifier(color: .green))
                }
            }
        }
        
        // MARK: - Load the LuckyCart banners when the view appears -->
        
        .task {
            loadBanner(bannerId: LuckyShop.homePageBanner, format: LuckyShop.bannerFormat)
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
