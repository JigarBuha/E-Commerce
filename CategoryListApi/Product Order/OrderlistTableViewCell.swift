//
//  OrderlistTableViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 12/09/23.
//

import UIKit

class OrderlistTableViewCell: UITableViewCell {

    @IBOutlet weak var lblshippingname: UILabel!
    @IBOutlet weak var lblshippingmobileno: UILabel!
    @IBOutlet weak var lblshippingaddress: UILabel!
   
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var lblorderid: UILabel!
    @IBOutlet weak var lblorderdate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
