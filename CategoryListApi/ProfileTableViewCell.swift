//
//  ProfileTableViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 30/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var Myimg: UIImageView!
    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblmobile: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
