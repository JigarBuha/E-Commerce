//
//  ViewwishlistViewController.swift
//  CategoryListApi
//
//  Created by Apple on 26/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ViewwishlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBAction func BtnAddtoCart(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "AddtocartViewController") as! AddtocartViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBOutlet weak var WishlistTableView: UITableView!
    var arr_product_name = [String]()
    var arr_product_image = [String]()
    var arr_product_price = [String]()
    var arr_wishlist_id = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_product_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! MywishlistTableViewCell
        cell.lblproname.text = arr_product_name[indexPath.row]
        cell.lblwishlistid.text = arr_wishlist_id[indexPath.row]
        cell.lblproprice.text = arr_product_price[indexPath.row]
        
        let url = URL(string: arr_product_image[indexPath.row])
        cell.Myimageview.af.setImage(withURL: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let deleteaction = UIAlertController(title: "My Wishlist", message: "Your Record Here", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
            { (alert) in
                self.API_WishlistRemove(wishlist_id: self.arr_wishlist_id[indexPath.row])
                
                let simpleaction = UIAlertController(title: "Delete", message: "Record Deleted", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                simpleaction.addAction(ok)
                self.present(simpleaction,animated: true ,completion: nil)
            }
            
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteaction.addAction(Delete)
            deleteaction.addAction(Cancel)
            self.present(deleteaction,animated: true,completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API_ViewWhishlist()
        WishlistTableView.dataSource = self
        WishlistTableView.delegate = self
    }

    func API_ViewWhishlist(){
        let id =  UserDefaults.standard.string(forKey: "uid")
        //print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-wishlist-view.php"
        let param:Parameters = ["user_id":id!]
        AF.request(url, method: .post ,parameters: param).responseJSON{(response) in
            switch response.result{
            case .success:
                let myresult = try?JSON(data: response.data!)
                print(response.result)
            
                let resultArray = myresult!["wishlist"]
                self.arr_product_name.removeAll()
                self.arr_product_image.removeAll()
                self.arr_product_price.removeAll()
                self.arr_wishlist_id.removeAll()
                
                for i in resultArray.arrayValue{
                    let product_name = i["product_name"].stringValue
                    self.arr_product_name.append(product_name)
                    
                    let product_image = i["product_image"].stringValue
                    self.arr_product_image.append(product_image)
                    
                    let product_price = i["product_price"].stringValue
                    self.arr_product_price.append(product_price)
                    
                    let wishlist_id = i["wishlist_id"].stringValue
                    self.arr_wishlist_id.append(wishlist_id)
                    
                    print(product_name)
                    print(product_image)
                    print(product_price)
                    print(wishlist_id)
                    
                }
                self.WishlistTableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }
    func API_WishlistRemove(wishlist_id:String){
        let url = "https://jigar.in/myapi/atecom1/api/api-wishlist-remove.php"
        let param:Parameters = ["wishlist_id":wishlist_id]
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
      API_ViewWhishlist()
    }
}
   


