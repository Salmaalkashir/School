//
//  EventsCollectionViewCell.swift
//  School
//
//  Created by Salma Alkashir on 23/02/2025.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var eventImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    cellSetup()
  }
  
  //MARK: - Setup Cell
  func cellSetup() {
    eventImage.layer.cornerRadius = 4
    layer.cornerRadius = 5
    layer.borderWidth = 0.5
    layer.borderColor = UIColor.primary.cgColor
  }
  
}
