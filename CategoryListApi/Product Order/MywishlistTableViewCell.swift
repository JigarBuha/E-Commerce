//
//  MywishlistTableViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 26/10/23.
//

import UIKit

class MywishlistTableViewCell: UITableViewCell {

    @IBOutlet weak var lblprodetails: UILabel!
    @IBOutlet weak var lblproid: UILabel!
    @IBOutlet weak var Myimageview: UIImageView!
    @IBOutlet weak var lblproname: UILabel!
    @IBOutlet weak var lblproprice: UILabel!
    @IBOutlet weak var lblwishlistid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
