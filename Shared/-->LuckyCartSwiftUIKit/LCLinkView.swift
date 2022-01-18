//
//  LCLinkView.swift
//  Lucky Shop
//
//  Created by Tristan Leblanc on 18/01/2022.
//

import SwiftUI
import LuckyCart

#if os(macOS)
extension View {
    private func newWindowInternal(title: String, geometry: NSRect, style: NSWindow.StyleMask, delegate: NSWindowDelegate) -> NSWindow {
        let window = NSWindow(
            contentRect: geometry,
            styleMask: style,
            backing: .buffered,
            defer: false)
        window.center()
        window.isReleasedWhenClosed = false
        window.title = title
        window.makeKeyAndOrderFront(nil)
        window.delegate = delegate
        return window
    }
    
    func openNewWindow(title: String, delegate: NSWindowDelegate, geometry: NSRect = NSRect(x: 20, y: 20, width: 640, height: 480), style:NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable]) {
        self.newWindowInternal(title: title, geometry: geometry, style: style, delegate: delegate).contentView = NSHostingView(rootView: self)
    }
}
#endif

struct LCLinkView: View {
    @State var link: LCLink
    @State var isOpen: Bool = false
    
    var placeHolder: Image
    
    var body: some View {
        ZStack(alignment: .center) {
            AsyncImage(url: link.imageUrl, content: { image in
                image.scaledToFit()
            }, placeholder: {
                placeHolder.scaledToFill()
            }).scaledToFit()
            Button("") {
                isOpen = true
            }.scaledToFill()
                .sheet(isPresented: $isOpen, content: {
                    VStack {
                        LCWebView(request: URLRequest(url: link.url))
                        Button("Close") {
                            isOpen = false
                        }
                        .modifier(ShopButtonModifier(color: .blue))
                    }
                })
        }
        .scaledToFit()
        .cornerRadius(10)
    }
}

struct LCLinkView_Previews: PreviewProvider {
    static var previews: some View {
        LCLinkView(link: LuckyCart.testBanner.link, placeHolder: Image("luckyCartBanner"))
    }
}
