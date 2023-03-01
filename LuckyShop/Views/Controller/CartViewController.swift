//
//  CartViewController.swift
//  LuckyShop
//
//  Created by Lucky Cart on 27/01/2023.
//

import UIKit

class CartViewController: LuckyShopViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        
        tableView.register(CartProductCell.self)
        tableView.register(EmptyCartCell.self)
        tableView.register(TotalCartCell.self)
        tableView.register(ButtonCell.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated(_:)),
                                               name: NSNotification.Name("cartUpdatedNotification"),
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func cartUpdated(_ notification: Notification) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    var numberOfProductsLines: Int {
        return Cart.shared.products?.count ?? 0
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if numberOfProductsLines == 0 {
            return 1
        }
        else {
            return numberOfProductsLines + 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if numberOfProductsLines == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCartCell.identifier, for: indexPath) as? EmptyCartCell
            return cell ?? UITableViewCell()
        }
        else {
            if (indexPath.row < (tableView.numberOfRows(inSection: indexPath.section) - 2)) {
                let cell = tableView.dequeueReusableCell(withIdentifier: CartProductCell.identifier, for: indexPath) as? CartProductCell
                cell?.product = Cart.shared.products?[indexPath.row]
                return cell ?? UITableViewCell()
            }
            else {
                if (indexPath.row < (tableView.numberOfRows(inSection: indexPath.section) - 1)) {
                    let cell = tableView.dequeueReusableCell(withIdentifier: TotalCartCell.identifier, for: indexPath) as? TotalCartCell
                    cell?.finalAtiAmount = Cart.shared.finalAtiAmount
                    return cell ?? UITableViewCell()
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell
                    cell?.title = "Proceed to paiement"
                    cell?.closure = { [weak self] in
                        if Customer.shared.isLogged {
                            let destinationViewController = CartValidationViewController.controller()
                            self?.show(destinationViewController, sender: self)
                        }
                        else {
                            let dialogBox = UIAlertController(title: "You are not logged in",
                                                           message: "Please log in by clicking on the account button at the top right of the interface.",
                                                           preferredStyle: .alert)
                            let okButton = UIAlertAction(title: "OK", style: .cancel)
                            dialogBox.addAction(okButton)
                            self?.present(dialogBox, animated: true)
                        }
                    }
                    return cell ?? UITableViewCell()
                }
            }
        }
    }

}
