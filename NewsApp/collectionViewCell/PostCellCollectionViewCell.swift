//
//  PostCellCollectionViewCell.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit

class PostCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var pauthercompany: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
    }
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor.black.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor.black.cgColor
    }*/

}

