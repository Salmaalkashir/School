//
//  CategoriesCollectionViewCell.swift
//  School
//
//  Created by Salma Alkashir on 23/02/2025.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.primary.cgColor
    }
    
    func configureCell(image: String, name: String) {
        categoryImage.image = UIImage(named: image)
        categoryName.text = name
    }

}
