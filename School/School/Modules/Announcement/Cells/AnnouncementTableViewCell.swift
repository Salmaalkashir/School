//
//  AnnouncementTableViewCell.swift
//  School
//
//  Created by Salma Alkashir on 07/03/2025.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var boarderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        boarderView.layer.cornerRadius = 10
        boarderView.layer.borderWidth = 2
        boarderView.layer.borderColor = UIColor.background.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
