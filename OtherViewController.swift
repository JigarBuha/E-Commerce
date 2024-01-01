//
//  OtherViewController.swift
//  CategoryListApi
//
//  Created by Apple on 17/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class OtherViewController: UIViewController {

    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var MyImageView: UIImageView!
    
    var product_name = ""
    var imageview = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblproductname.text = product_name
       // let url = URL(string: imageview)
       // self.MyImageView.af.setImage(withURL: url!)
    }
    

   
}
