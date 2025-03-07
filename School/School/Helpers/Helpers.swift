//
//  Helpers.swift
//  School
//
//  Created by Salma Alkashir on 07/03/2025.
//

import UIKit

class Helpers {
  static func registerNib(nibName: String, cellName: String, view: Any) {
      if view as? any Any.Type == UICollectionView.self {
      let nib = UINib(nibName: nibName, bundle: nil)
          (view as AnyObject).register(nib, forCellWithReuseIdentifier: cellName)
      }else if view as? any Any.Type == UITableView.self {
      let nib = UINib(nibName: nibName, bundle: nil)
          (view as AnyObject).register(nib, forCellReuseIdentifier: cellName)
    }
  }
}
