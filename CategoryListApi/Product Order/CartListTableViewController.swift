import Alamofire
import AlamofireImage
import UIKit
import SwiftyJSON
class CartListTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var CartListTableView: UITableView!
    var arr_cart_id = [String]()
    var arr_product_id = [String]()
    var arr_product_name = [String]()
    var arr_product_details = [String]()
    var arr_product_price = [String]()
    var arr_product_qty = [String]()
    var arr_product_image = [String]()
  //  var arr_grand_total = [String]()
    var mytotal = 0

    @IBAction func BtnPlaceOrder(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "AddOrderViewController") as! AddOrderViewController
            self.navigationController?.pushViewController(main, animated: true)
    }
    @IBOutlet weak var btnplaceorder: UIButton!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_product_name.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartlistcell") as! cartListTableViewCell
        cell.lblcartid.text = arr_cart_id[indexPath.row]
        cell.lblpid.text = arr_product_id[indexPath.row]
        cell.lblpname.text = arr_product_name[indexPath.row]
        cell.lblpdetails.text = arr_product_details[indexPath.row]
        cell.lblpprice.text = arr_product_price[indexPath.row]
        cell.lblpqty.text = arr_product_qty[indexPath.row]
        let url = URL(string: arr_product_image[indexPath.row])
        cell.pimageview.af.setImage(withURL: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let deleteaction = UIAlertController(title: "Cart List", message: "Your Record Here", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
            { (alert) in
                self.API_CartRemove(cart_id: self.arr_cart_id[indexPath.row])
                
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
    func placebtnShow(){
        if(mytotal == 0)
        {
            btnplaceorder.isHidden = true
            
        }
        else
        {
            btnplaceorder.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        API_CartList()
        CartListTableView.dataSource = self
        CartListTableView.delegate = self
        placebtnShow()
        lblgrandtotal.text = String(mytotal)
    }
    override func viewWillAppear(_ animated: Bool) {
        placebtnShow()
    }
    func API_CartList(){
        let id =  UserDefaults.standard.string(forKey: "uid")
       // print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-cart-list.php"
        let param:Parameters = ["user_id":id!]
        AF.request(url, method: .post ,parameters: param).responseJSON{(response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try?JSON(data: response.data!)
                print(myresult!["cart_list"])
                let resultArray = myresult!["cart_list"]
                print(resultArray["cart_list"])
                
                self.arr_cart_id.removeAll()
                self.arr_product_id.removeAll()
                self.arr_product_name.removeAll()
                self.arr_product_details.removeAll()
                self.arr_product_price.removeAll()
                self.arr_product_qty.removeAll()
                self.arr_product_image.removeAll()
               // self.arr_grand_total.removeAll()
                
                for i in resultArray.arrayValue{
                    let cart_id = i["cart_id"].stringValue
                    self.arr_cart_id.append(cart_id)
                    
                    let product_id = i["product_id"].stringValue
                    self.arr_product_id.append(product_id)
                    
                    let product_name = i["product_name"].stringValue
                    self.arr_product_name.append(product_name)
                    
                    let product_details = i["product_details"].stringValue
                    self.arr_product_details.append(product_details)
                    
                    let product_price = i["product_price"].stringValue
                    self.arr_product_price.append(product_price)
                    
                    let product_qty = i["product_qty"].stringValue
                    self.arr_product_qty.append(product_qty)
                    
                    let product_image = i["product_image"].stringValue
                    self.arr_product_image.append(product_image)
                    
                    //let grand_total = i["grand_total"].stringValue
                   // self.arr_grand_total.append(grand_total)
                    
                    print(cart_id)
                    print(product_id)
                    print(product_name)
                    print(product_details)
                    print(product_price)
                    print(product_qty)
                    print(product_image)
                 //   print(grand_total)
                    
                    self.mytotal += Int(product_price)!
                    self.lblgrandtotal.text = String(self.mytotal)
                    self.placebtnShow()
                }
                self.CartListTableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }
    func API_CartRemove(cart_id:String){
        self.mytotal = 0
        let url = "https://jigar.in/myapi/atecom1/api/api-cart-remove-product.php"
        let param:Parameters = ["cart_id":cart_id]
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
      API_CartList()
    }
}
