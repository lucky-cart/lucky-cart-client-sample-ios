//
//  AppDelegate.swift
//  LuckyShop
//
//  Created by Lucky Cart on 19/01/2023.
//

import UIKit
import LuckyCartSDK
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NFX.sharedInstance().start()
        
        LuckyCart.shared.setSiteKey("A2ei4iyi")
        
        initializeShopContents()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    
    func initializeShopContents() {
        Shop.shared.categories = [
            Category(id: "100",
                     title: "Coffees",
                     image: UIImage(named: "Coffees") ?? UIImage(),
                     products: [
                        Product(id: "COFFEE", title: "Kenyan Coffee", image: UIImage(named: "Coffee") ?? UIImage(), price: 7.5, categoryId: "100"),
                        Product(id: "COFFEE2", title: "Columbian Coffee", image: UIImage(named: "Coffee2") ?? UIImage(), price: 12.2, categoryId: "100")
                     ]),
            Category(id: "200",
                     title: "Fruits",
                     image: UIImage(named: "Fruits") ?? UIImage(),
                     products: [
                        Product(id: "APPLEGREEN", title: "Green Apple", image: UIImage(named: "Apple.green") ?? UIImage(), price: 3.5, categoryId: "200"),
                        Product(id: "APPLERED", title: "Red Apple", image: UIImage(named: "Apple.red") ?? UIImage(), price: 3.5, categoryId: "200"),
                        Product(id: "BANANAS", title: "Bananas", image: UIImage(named: "Bananas") ?? UIImage(), price: 3.8, categoryId: "200"),
                        Product(id: "COCONUT", title: "Coconut", image: UIImage(named: "Coconut") ?? UIImage(), price: 5.0, categoryId: "200")
                     ]),
        ]
    }
}

