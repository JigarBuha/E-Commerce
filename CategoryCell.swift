//
//  MyCollectionViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 24/11/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var Myimageview: UIImageView!
    @IBOutlet weak var Mylabel: UILabel!
    func randomColor() -> UIColor {
           let red = CGFloat(drand48())
           let green = CGFloat(drand48())
           let blue = CGFloat(drand48())
           
        return UIColor(red: red, green: green, blue: blue, alpha: 0.1)
       }
    override func awakeFromNib() {
           super.awakeFromNib()
        self.Mylabel.isUserInteractionEnabled = false
        self.contentView.backgroundColor = randomColor()

       }
}

