//
//  DetailsViewController.swift
//  CategoryListApi
//
//  Created by Apple on 31/10/23.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class DetailsViewController: UIViewController {

    @IBOutlet weak var uid: UILabel!
    @IBOutlet weak var oid: UILabel!
    var orderid = ""
    @IBOutlet weak var myimg: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    var orderID = UserDefaults.standard.object(forKey: "oid") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API_OrderDetails()
        oid.text = orderid
    }
    
    func API_OrderDetails(){
       
        let uid = UserDefaults.standard.string(forKey: "uid")
        let oid =  UserDefaults.standard.string(forKey: "oid")
        //print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-order-list.php?order_id=\(orderID)"
        let param:Parameters = ["order":oid!]
        AF.request(url, method: .post,parameters: param ).responseJSON{(response) in
            switch response.result{
            case .success:
              //  let myresult = JSON(response.data!)
                print(response.result)
                let myresult = try?JSON(data: response.data!)
                print(myresult!["order_details"])
              
               // let resultArray = myresult!["order_details"]
               // print(resultArray["order_details"])
                
              //  let P_photo = myresult["product_image"].stringValue
              //  self.myimg.image = UIImage(named: P_photo)
                let P_Name = myresult!["product_name"].stringValue
                self.lblname.text = P_Name
                let P_Price = myresult!["product_price"].stringValue
                self.lblprice.text = P_Price
                let P_Total = myresult!["sub_total"].stringValue
                self.lbltotal.text = P_Total
                let P_Qty = myresult!["product_qty"].stringValue
                self.lblqty.text = P_Qty
            
                break
            case .failure:
                break
            }
        }
    }

}
