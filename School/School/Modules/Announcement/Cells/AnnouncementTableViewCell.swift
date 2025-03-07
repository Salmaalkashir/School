//
//  AnnouncementTableViewCell.swift
//  School
//
//  Created by Salma Alkashir on 07/03/2025.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    @IBOutlet weak var message: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.background.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
