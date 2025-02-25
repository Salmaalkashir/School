//
//  AnnouncementsCollectionViewCell.swift
//  School
//
//  Created by Salma Alkashir on 23/02/2025.
//

import UIKit

class AnnouncementsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.background.cgColor
    }

}
