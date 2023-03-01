//
//  CategoryViewController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit
import LuckyCartSDK

class CategoryViewController: LuckyShopViewController {
    
    var category: Category? {
        didSet {
            title = category?.title
            pageId = category?.id
            tableView.reloadData()
        }
    }
    
    var bannerExperience: LCBannerExperience? {
        didSet {
            guard let _ = bannerExperience else { return }
            
            tableView.reloadData()
        }
    }
    
    static func controller() -> CategoryViewController {
        let viewController = UIStoryboard(name: "CategoryViewController", bundle: nil).instantiateInitialViewController() as! CategoryViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageType = "categories"
        
        tableView.register(ProductCell.self)
        tableView.register(LCContainerCell.self, forCellReuseIdentifier: LCBannerView.identifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Customer.shared.isLogged {
            let payload = LCEventPayload(pageType: pageType, pageId: pageId, storeType: storeType, storeId: storeId)
            LuckyCart.shared.sendShopperEvent(eventName: .pageViewed, payload: payload) { [weak self] eventSended in
                print("LUCKYSHOP :: LUCKY CART // EVENT SENDED")
                if self?.bannerExperience == nil {
                    self?.updateLuckyCartBanner()
                }
            }
        }
    }
    
    override func updateLuckyCartBanner() {
        LuckyCart.shared.getBannerExperienceDetail(pageType: pageType ?? "Homepage",
                                                   format: "banner",
                                                   pageId: pageId,
                                                   store: storeId,
                                                   storeType: storeType) { [weak self] bannerExperience in
            print(bannerExperience ?? "NO BANNER")
            self?.bannerExperience = bannerExperience
        }
        
    }
}

extension CategoryViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfProducts = category?.products.count ?? 0
        return bannerExperience != nil ? numberOfProducts + 1 : numberOfProducts
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let bannerExperience = bannerExperience {
            let bannerView = LCBannerView.load(owner: self)
            bannerView.bannerExperience = bannerExperience
            bannerView.storeId = storeId
            bannerView.storeType = storeType
            bannerView.pageId = pageId
            bannerView.pageType = pageType
            let cell = bannerView.dequeue(tableView, indexPath)
            return cell
        }
        else {
            let productIndex = bannerExperience != nil ? indexPath.row - 1 : indexPath.row
            let product = category?.products[productIndex]
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell
            cell?.product = product
            return cell ?? UITableViewCell()
        }
    }
}
