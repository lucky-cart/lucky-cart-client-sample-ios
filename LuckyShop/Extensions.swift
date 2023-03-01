//
//  Extensions.swift
//  LuckyShop
//
//  Created by Lucky Cart on 26/01/2023.
//

import Foundation

import UIKit


extension NSObject {
  public var identifier: String {
    String(describing: type(of: self))
  }

  public static var identifier: String {
    String(describing: self)
  }
}

extension UITableView {
    
    public func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
}

extension Double {
    
    func toPrice() -> String {
        return String(format: "%.2f €", self)
    }
}

extension UIViewController {
  func isVisible() -> Bool {
      return self.isViewLoaded && self.view.window != nil
  }
}
