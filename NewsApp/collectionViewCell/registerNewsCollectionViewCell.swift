//
//  registerNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 9.04.2023.
//

import UIKit

class registerNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
   
    @IBOutlet weak var newsTitle: UILabel!
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        newsImage.layer.cornerRadius = 12
    }
}

