//
//  ViewfeedbackTableViewCell.swift
//  CategoryListApi
//
//  Created by Apple on 14/10/23.
//

import UIKit

class ViewfeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var lblfeedbackid: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblfeedbackrate: UILabel!
    @IBOutlet weak var lblfeedbackdateandtime: UILabel!
    @IBOutlet weak var lblfeedbackdetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
