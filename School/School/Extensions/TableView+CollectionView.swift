//
//  Helpers.swift
//  School
//
//  Created by Salma Alkashir on 07/03/2025.
//

import UIKit

extension UITableView {
  func registerNib<T: UITableViewCell>(cellType: T.Type, identifier: String) {
    let nib = UINib(nibName: String(describing: cellType), bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
}

extension UICollectionView {
  func registerNib<T: UICollectionViewCell>(cellType: T.Type, identifier: String) {
    let nib = UINib(nibName: String(describing: cellType), bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: identifier)
  }
}
