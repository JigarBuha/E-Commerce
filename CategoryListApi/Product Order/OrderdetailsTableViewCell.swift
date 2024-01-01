//
//  OrderdetailsTableViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 12/10/23.
//

import UIKit

class OrderdetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblproductprice: UILabel!
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var lbltotalprice: UILabel!
    @IBOutlet weak var lblproductqty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
