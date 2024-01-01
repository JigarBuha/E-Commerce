//
//  ProductCell.swift
//  
//
//  Created by Apple on 08/12/23.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var Proimage: UIImageView!
    @IBOutlet weak var Prolbl: UILabel!
    func randomColor() -> UIColor {
           let red = CGFloat(drand48())
           let green = CGFloat(drand48())
           let blue = CGFloat(drand48())
           
        return UIColor(red: red, green: green, blue: blue, alpha: 0.3)
       }
    override func awakeFromNib() {
           super.awakeFromNib()
        self.contentView.backgroundColor = randomColor()
           // Set corner radius for the image view
       
       // view.layer.cornerRadius = 20.0
           //Bluebg.layer.masksToBounds = true
       }
}
