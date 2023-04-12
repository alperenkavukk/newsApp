//
//  CustomCellCollectionViewCell.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 4.04.2023.
//

import UIKit

class CustomCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelname: UILabel!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    
  
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
    } 
    func configur ( with name : String){
        labelname.text = name
    }
    override var isSelected: Bool {
          didSet {
              self.backgroundColor = isSelected ? .systemTeal : .systemGray6
          }
      }
  }

