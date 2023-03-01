//
//  LuckyShopViewController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 26/01/2023.
//

import UIKit

enum BannerType {
    case onlyOne
    case multiple
}

class LuckyShopViewController: UITableViewController {
    
    var pageType: String?
    var pageId: String?
    var storeId: String = "12324"
    var storeType: String = "sup"
    var bannerType: BannerType = .onlyOne
    
    
    override func viewDidLoad() {
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadViews(_:)),
                                               name: NSNotification.Name("LuckyCartBannerImageLoadedNotification"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(inShopAction(_:)),
                                               name: NSNotification.Name("LuckyCartBannerInShopAction"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func reloadViews(_ notification: Notification) {
        self.tableView.beginUpdates()
        self.tableView.setNeedsDisplay()
        self.tableView.endUpdates()
    }
    
    @objc
    func inShopAction(_ notification: Notification) {
        guard let dict = notification.userInfo,
              let inShopPath = dict["shopInShopRedirectMobile"] as? String,
        isVisible() else { return }
        
        if inShopPath == "query_200" {
            let destinationViewController = CategoryViewController.controller()
            destinationViewController.category = Shop.shared.categories?.last
            show(destinationViewController, sender: self)
        }
        else if inShopPath == "query_100" {
            let destinationViewController = CategoryViewController.controller()
            destinationViewController.category = Shop.shared.categories?.first
            show(destinationViewController, sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureLoginButton()
    }
    
    func configureLoginButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Customer.shared.isLogged ? "person.fill.checkmark" : "person.fill.xmark"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressLoginButton))
        navigationItem.rightBarButtonItem?.tintColor = Customer.shared.isLogged ? .systemGreen : .systemRed
        
    }
    
    @objc
    func pressLoginButton() {
        Customer.shared.isLogged.toggle()
        configureLoginButton()
        updateLuckyCart()
    }
    
    open func updateLuckyCart() {}
    open func updateLuckyCartBanner() {}
    open func updateLuckyCartBanners() {}
}
