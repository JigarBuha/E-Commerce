//
//  OrderListViewController.swift
//  CategoryListApi
//
//  Created by Apple on 12/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class OrderdetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBAction func Btnhome(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "Category") as! Category
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBOutlet weak var OrderdetailsTableView: UITableView!
    var arr_product_name = [String]()
    var arr_product_price = [String]()
    var arr_sub_total = [String]()
    var arr_product_qty = [String]()
    var arr_product_image = [String]()
    
    @IBOutlet weak var txtorderid: UITextField!
    var order_id = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_product_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! OrderdetailsTableViewCell
        cell.lblproductname.text = arr_product_name[indexPath.row]
        cell.lblproductprice.text = arr_product_price[indexPath.row]
        cell.lbltotalprice.text = arr_sub_total[indexPath.row]
        cell.lblproductqty.text = arr_product_qty[indexPath.row]
        
       // let url = URL(string: arr_product_image[indexPath.row])
      //  cell.MyImageView.af.setImage(withURL: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            
            let deleteaction = UIAlertController(title: "Order List", message: "Your Record Here", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
        { (alert) in
            self.API_OrderRemove(user_id: self.arr_product_name[indexPath.row],order_id: self.arr_product_name[indexPath.row], cancel_reason: self.arr_product_name[indexPath.row])
         
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
        API_OrderDetails()
        OrderdetailsTableView.dataSource = self
        OrderdetailsTableView.delegate = self
    }
    func API_OrderDetails(){
        let id = UserDefaults.standard.string(forKey: "uid")
      //  print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-order-list.php?order_id=\(order_id)"
        let param:Parameters = ["user_id":id!]
        AF.request(url,method: .post,parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try?JSON(data: response.data!)
                print(myresult!["order_details"])
              
                let resultArray = myresult!["order_details"]
                print(resultArray["order_details"])
                
                self.arr_product_name.removeAll()
                self.arr_product_price.removeAll()
                self.arr_sub_total.removeAll()
                self.arr_product_qty.removeAll()
                self.arr_product_image.removeAll()
                
                for i in resultArray.arrayValue{
                    let product_name = i["product_name"].stringValue
                    self.arr_product_name.append(product_name)
                    
                    let product_price = i["product_price"].stringValue
                    self.arr_product_price.append(product_price)
                    
                    let sub_total = i["sub_total"].stringValue
                    self.arr_sub_total.append(sub_total)
                    
                    let product_qty = i["product_qty"].stringValue
                    self.arr_product_qty.append(product_qty)
                    
                    let product_image = i["product_image"].stringValue
                    self.arr_product_image.append(product_image)
                    
                    print(product_name)
                    print(product_price)
                    print(sub_total)
                    print(product_qty)
                    print(product_image)
                }
                self.OrderdetailsTableView.reloadData()
                break
                case .failure:
                    break
                }
                
            }
        }
    func API_OrderRemove(user_id:String,order_id:String,cancel_reason:String){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-order-remove.php"
        let param:Parameters = ["user_id":user_id,
                                "order_id":order_id,
                                "cancel_reason":cancel_reason]
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
        API_OrderDetails()
    }
        
}


    

