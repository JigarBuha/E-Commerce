//
//  CartInsertViewController.swift
//  Pods
//
//  Created by Apple on 23/08/23.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AddtocartViewController: UIViewController {

    @IBOutlet weak var TxtUserid: UITextField!
    @IBOutlet weak var TxtProduct_id: UITextField!
    @IBOutlet weak var TxtProduct_Qty: UITextField!
    @IBOutlet weak var TxtProduct_name: UITextField!
    @IBOutlet weak var TxtProduct_price: UITextField!
    @IBOutlet weak var lblProduct_details: UILabel!
    @IBOutlet weak var Cartimageview: UIImageView!
    @IBAction func BtnCartInsert(_ sender: Any) {
        API_CartInsert()
        TxtProduct_Qty.text = ""
      
    }
    @IBOutlet weak var MyStepper: UIStepper!
    @IBAction func MystepperAction(_ sender: Any) {
        TxtProduct_Qty.text = (String(Int(MyStepper.value)))
}
    
    var product_id = ""
    var product_name = ""
    var product_price = ""
    var productdetails = ""
    var imageview = ""
    @IBAction func BtnLogin(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    @IBAction func BtnAddWishlist(_ sender: Any) {
        API_AddWishlist()
        let main = storyboard?.instantiateViewController(identifier: "ViewwishlistViewController") as! ViewwishlistViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBOutlet weak var Btnlogin: UIButton!
    @IBOutlet weak var Btnaddtocart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtProduct_id.text = product_id
        TxtProduct_name.text = product_name
        TxtProduct_price.text = product_price
        lblProduct_details.text = productdetails
        let url = URL(string: imageview)
        self.Cartimageview.af.setImage(withURL: url!)
        
        TxtUserid.text = UserDefaults.standard.string(forKey: "uid")
        TxtProduct_id.isHidden = true
        TxtUserid.isHidden = true
        TxtProduct_Qty.text = "1"
        Cartimageview.layer.cornerRadius = 20
        Btnlogin.layer.cornerRadius = 20
        Btnaddtocart.layer.cornerRadius = 20
    }
    func API_CartInsert(){
        let id = UserDefaults.standard.string(forKey: "uid")
       // print(id)
        let url = "https://jigar.in/myapi/atecom1/api/api-cart-insert.php"
        let param:Parameters = ["user_id":id!,
                                "product_id":TxtProduct_id.text!,
                                "product_qty":TxtProduct_Qty.text!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
               print(responseData)

                
                break
            case .failure:
                break
            }
        }
    }
    func API_AddWishlist(){
        var id =  UserDefaults.standard.string(forKey: "uid")
        print(id)
        let url = "https://jigar.in/myapi/atecom1/api/api-wishlist-add.php"
        let param:Parameters = ["user_id":id!,
                                "product_id":TxtProduct_id.text!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
                
            break
            case .failure:
                break
            }
        }
        
    }

}
