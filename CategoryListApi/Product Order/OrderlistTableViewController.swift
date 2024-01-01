//
//  OrderlistViewController.swift
//  CategoryListApi
//
//  Created by Apple on 24/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class OrderlistTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var OrderListTableView: UITableView!
    var arr_shipping_name = [String]()
    var arr_shipping_mobile = [String]()
    var arr_shipping_address = [String]()
    var arr_order_id = [String]()
    var arr_order_date = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_shipping_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordercell") as! OrderlistTableViewCell
        cell.lblshippingname.text = arr_shipping_name[indexPath.row]
        cell.lblshippingmobileno.text = arr_shipping_mobile[indexPath.row]
        cell.lblshippingaddress.text = arr_shipping_address[indexPath.row]
        cell.lblorderid.text = arr_order_id[indexPath.row]
        cell.lblorderdate.text = arr_order_date[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            
            let deleteaction = UIAlertController(title: "Order List", message: "Your Record Here", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
        { (alert) in
            self.API_OrderRemove(order_id: self.arr_order_id[indexPath.row], cancel_reason: self.arr_order_id[indexPath.row])
         
                let simpleaction = UIAlertController(title: "Delete", message: "Record Deleted", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                simpleaction.addAction(ok)
                self.present(simpleaction,animated: true ,completion: nil)
            }
            
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteaction.addAction(Delete)
            deleteaction.addAction(Cancel)
            self.present(deleteaction,animated: true,completion: nil)
            OrderListTableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        main.orderid = arr_order_id[indexPath.row]
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        API_OrderList()
        OrderListTableView.dataSource = self
        OrderListTableView.delegate = self
    }
    func API_OrderList(){
        let id = UserDefaults.standard.string(forKey: "uid")
//        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-order-list.php"
        let param:Parameters = ["user_id":id!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try?JSON(data: response.data!)
                print(myresult!["order_list"])
              
                let resultArray = myresult!["order_list"]
                print(resultArray["order_list"])
                
                let responseData = JSON(response.data!)
                print(responseData)
                let orderid = responseData["order_id"];
                 let myneworderid = "\(orderid)"
                 print(myneworderid)
                 //ID Save
                 UserDefaults.standard.set(myneworderid, forKey: "oid")
                
                self.arr_shipping_name.removeAll()
                self.arr_shipping_mobile.removeAll()
                self.arr_shipping_address.removeAll()
                self.arr_order_id.removeAll()
                self.arr_order_date.removeAll()
             
                
                for i in resultArray.arrayValue{
                    let shipping_name = i["shipping_name"].stringValue
                    self.arr_shipping_name.append(shipping_name)
                    
                    let shipping_mobile = i["shipping_mobile"].stringValue
                    self.arr_shipping_mobile.append(shipping_mobile)
                    
                    let shipping_address = i["shipping_address"].stringValue
                    self.arr_shipping_address.append(shipping_address)
                    
                    let order_id = i["order_id"].stringValue
                    self.arr_order_id.append(order_id)
                    
                    let order_date = i["order_date"].stringValue
                    self.arr_order_date.append(order_date)
                    
                    print(shipping_name)
                    print(shipping_mobile)
                    print(shipping_address)
                    print(order_id)
                    print(order_date)
                 
                }
                self.OrderListTableView.reloadData()
                break
                case .failure:
                    break
                }
                
            }
        }
    func API_OrderRemove(order_id:String,cancel_reason:String){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-order-remove.php"
        let param:Parameters = ["user_id":id!,
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
        API_OrderList()
    }
        
}

