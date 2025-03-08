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

extension UIViewController{
    func calcCollectionHeight(noOfCells: Int, noOfItemInRow: Int, cellHeight: Int, cellSpacing: Int) -> CGFloat{
        var noOfRows = 0
        if(noOfCells == 0){
            return CGFloat(10)
        }else if(noOfCells <= noOfItemInRow){
            return CGFloat(cellHeight + cellSpacing)
        }else if(noOfCells % noOfItemInRow == 0){
            noOfRows = (noOfCells/noOfItemInRow)
            return CGFloat(noOfRows * (cellHeight + cellSpacing) + cellSpacing)
        }else{
            noOfRows = (noOfCells/noOfItemInRow + 1)
            return CGFloat((noOfRows * (cellHeight + cellSpacing)) + cellSpacing)
        }
    }
}
