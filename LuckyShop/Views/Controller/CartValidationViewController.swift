//
//  CartValidationViewController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 28/01/2023.
//

import UIKit
import LuckyCartSDK

class CartValidationViewController: LuckyShopViewController {
    
    static func controller() -> CartValidationViewController {
        let viewController = UIStoryboard(name: "CartValidationViewController", bundle: nil).instantiateInitialViewController() as! CartValidationViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Thank you !"
        
        tableView.separatorStyle = .none
        tableView.register(ButtonCell.self)
        tableView.register(ApprouvedCell.self)
        tableView.register(LCContainerCell.self, forCellReuseIdentifier: LCBannerView.identifier())
        
        if Customer.shared.isLogged {
            let payload = Cart.shared.cartToLuckyCartPayload()
            LuckyCart.shared.sendShopperEvent(eventName: .cartValidated, payload: payload) { eventSended in
                print("LUCKYSHOP :: LUCKY CART :: EVENT CART VALIDATED SENDED")
                Cart.shared.removeAllProducts()
                let gameFilter = LCGameFilter(filters: [
                    LCFilter(filterProperty: "cartId",
                             filterValue: Cart.shared.cartId)
                ])
                LuckyCart.shared.getGamesAccess(filters: gameFilter) { [weak self] gamesExperiences in
                    self?.gameExperience = gamesExperiences?.first
                }
            }
        }
    }
    
    var gameExperience: LCGamesExperience? {
        didSet {
            guard let gameExperience = gameExperience else { return }
            print(gameExperience as Any)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameExperience != nil ? 3 : 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let gameExperience = gameExperience {
                let bannerView = LCBannerView.load(owner: self)
                bannerView.gameExperience = gameExperience
                bannerView.parentViewController = self
                let cell = bannerView.dequeue(tableView, indexPath)
                return cell
            }
            else {
                return approuvedCell(indexPath)
            }
        case 1:
            if let _ = gameExperience {
                return approuvedCell(indexPath)
            }
            else {
                return backToHomeCell(indexPath)
            }
        default:
            return backToHomeCell(indexPath)
        }
    }
    
    func approuvedCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApprouvedCell.identifier, for: indexPath) as? ApprouvedCell
        return cell ?? UITableViewCell()
    }
    
    func backToHomeCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell
        cell?.title = "Go to shop again"
        cell?.closure = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
            if let navigations = self?.tabBarController?.viewControllers {
                for item in navigations {
                    if let vc = item as? LuckyShopViewController {
                        vc.tableView.reloadData()
                    }
                    if let navigation = item as? UINavigationController {
                        navigation.popToRootViewController(animated: false)
                    }
                }
            }
        }
        return cell ?? UITableViewCell()
    }

}
