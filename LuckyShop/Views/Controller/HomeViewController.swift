//
//  ViewController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 19/01/2023.
//

import UIKit
import LuckyCartSDK

class HomeViewController: LuckyShopViewController {
    
    var bannerExperience: LCBannerExperience? {
        didSet {
            guard let _ = bannerExperience else { return }
            tableView.reloadData()
        }
    }
    
    var bannerExperiences: [LCBannerExperience]? {
        didSet {
            guard let _ = bannerExperiences else { return }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lucky Shop"
        pageType = "Homepage"
        bannerType = .multiple
        
        tableView.register(CategoryCell.self)
        tableView.register(LCContainerCell.self, forCellReuseIdentifier: LCBannerView.identifier())
        tableView.register(LCContainerCell.self, forCellReuseIdentifier: LCBannersView.identifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLuckyCart()
    }
    
    override func updateLuckyCart() {
        if Customer.shared.isLogged {
            let payload = LCEventPayload(pageType: pageType, pageId: pageId, storeType: storeType, storeId: storeId)
            LuckyCart.shared.sendShopperEvent(eventName: .pageViewed, payload: payload) { [weak self] eventSended in
                print("LUCKYSHOP :: LUCKY CART :: EVENT PAGE VIEWED SENDED")
                if self?.bannerExperiences == nil {
                    self?.updateLuckyCartBanners()
                }
//                if self?.bannerExperience == nil {
//                    self?.updateLuckyCartBanner()
//                }
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
    
    override func updateLuckyCartBanners() {
        
        LuckyCart.shared.getBannersExperience(pageType: pageType ?? "Homepage",
                                              format: "banner",
                                              pageId: pageId,
                                              store: storeId,
                                              storeType: storeType) { [weak self] bannerExperiences in
            print(bannerExperiences ?? "NO BANNERS")
            self?.bannerExperiences = bannerExperiences
        }
    }
}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasOneBannerAtLeast() ? 3 : 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if hasOneBannerAtLeast() {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
                cell?.category = Shop.shared.categories?.first
                return cell ?? UITableViewCell()
            case 1:
                if let singleBannerExperience = bannerExperience {
                    let bannerView = LCBannerView.load(owner: self)
                    bannerView.bannerExperience = singleBannerExperience
                    bannerView.storeId = storeId
                    bannerView.storeType = storeType
                    bannerView.pageId = pageId
                    bannerView.pageType = pageType
                    let cell = bannerView.dequeue(tableView, indexPath)
                    return cell
                }
                else if let multipleBannerExperiences = bannerExperiences {
                    let bannersView = LCBannersView.load(owner: self)
                    bannersView.storeId = storeId
                    bannersView.storeType = storeType
                    bannersView.pageId = pageId
                    bannersView.pageType = pageType
                    bannersView.bannerExperiences = multipleBannerExperiences
                    let cell = bannersView.dequeue(tableView, indexPath)
                    return cell
                }
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
                cell?.category = Shop.shared.categories?.last
                return cell ?? UITableViewCell()
            }
        }
        else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
                cell?.category = Shop.shared.categories?.first
                return cell ?? UITableViewCell()
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
                cell?.category = Shop.shared.categories?.last
                return cell ?? UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let categoryViewController = CategoryViewController.controller()
            categoryViewController.category = Shop.shared.categories?.first
            navigationController?.show(categoryViewController, sender: self)
        case 1:
            if hasOneBannerAtLeast() { return } 
            let categoryViewController = CategoryViewController.controller()
            categoryViewController.category = Shop.shared.categories?.last
            navigationController?.show(categoryViewController, sender: self)
        default:
            let categoryViewController = CategoryViewController.controller()
            categoryViewController.category = Shop.shared.categories?.last
            navigationController?.show(categoryViewController, sender: self)
        }
    }
}

extension HomeViewController {
    
    func hasOneBannerAtLeast() -> Bool {
//        return bannerExperience != nil || bannerExperiences != nil
        return (bannerExperience != nil) || (bannerExperiences?.count ?? 0 >= 1)
    }
}
