//
//  ProductView.swift
//
//  LuckyCart Framework Sample Client App - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 16/01/2022.
//

import SwiftUI
import LuckyCart

struct ProductView: View {
    
    @EnvironmentObject var shop: LuckyShop
    
    @State var item: LuckyShop.Product

    @State var banner: LCBanner?

    var bannerSpaceIdentifier: LCBannerSpaceIdentifier?
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let banner = banner {
                LCBannerView(banner: banner)
                .frame(width: 140, height: 140, alignment: .center)
            } else {
                if let imageName = item.imageName {
                    Image(imageName)
                        .resizable()
                        .frame(width: 140, height: 140, alignment: .center)
                        .fixedSize()
                }
            }
            VStack(alignment: .leading, spacing: 16) {
                Text(item.name).font(.caption).fixedSize()
                Button("Add To Cart") {
                    shop.cart.add(product: item)
                }
                .modifier(ShopButtonModifier())

            }.frame(alignment: .topLeading)
        }
        //.frame(minHeight: 80, idealHeight: 80, maxHeight: 80, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .task {
            guard let bannerSpaceIdentifier = bannerSpaceIdentifier else {
                return
            }
            if let bannerForProduct = shop.bannerIdentifier(for: item) {
                LuckyCart.shared.banner(with: bannerForProduct, bannerSpaceIdentifier: bannerSpaceIdentifier) { _ in
                    self.banner = nil
                } success: { banner in
                    self.banner = banner
                }
            }
        }

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(item: TestCatalog.fruits.products.first!)
    }
}
