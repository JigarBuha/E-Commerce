//
//  SubCollectionViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 24/11/23.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {
    @IBOutlet weak var subcatimageview: UIImageView!
    @IBOutlet weak var subname: UILabel!
    func randomColor() -> UIColor {
           let red = CGFloat(drand48())
           let green = CGFloat(drand48())
           let blue = CGFloat(drand48())
           
        return UIColor(red: red, green: green, blue: blue, alpha: 0.2)
       }
    override func awakeFromNib() {
           super.awakeFromNib()
        self.contentView.backgroundColor = randomColor()
        
       }
}


