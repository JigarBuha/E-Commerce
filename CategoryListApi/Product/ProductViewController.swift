import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var MyProductSearchbar: UISearchBar!
    var searcharrid = [String]()
    var searcharrname = [String]()
    var searcharrdetails = [String]()
    var searcharrprice = [String]()
    var searcharrquantity = [String]()
    var searcharrimage = [String]()
    var is_searching = false
    @IBOutlet weak var lblsubcatid: UILabel!
    var sub_category_id = ""
    @IBOutlet weak var ProductListTableView: UITableView!
    var arr_product_id = [String]()
    var arr_product_name = [String]()
    var arr_product_details = [String]()
    var arr_product_price = [String]()
    var arr_product_quantity = [String]()
    var arr_product_image = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if is_searching{
            return searcharrname.count
        }
        else{
            return arr_product_name.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "procell") as! ProductTableViewCell
       
        if is_searching{
            cell.lblproductid.text = searcharrid[indexPath.row]
            cell.lblproductname.text = searcharrname[indexPath.row]
            cell.lblproductdetails.text = searcharrdetails[indexPath.row]
            cell.lblproductprice.text = searcharrprice[indexPath.row]
            cell.lblproductqty.text = searcharrquantity[indexPath.row]
            let url = URL(string: searcharrimage[indexPath.row])
            cell.proimageview.af.setImage(withURL: url!)
        }
        
        else{
            cell.lblproductid.text = arr_product_id[indexPath.row]
            cell.lblproductname.text = arr_product_name[indexPath.row]
            cell.lblproductdetails.text = arr_product_details[indexPath.row]
            cell.lblproductprice.text = arr_product_price[indexPath.row]
            cell.lblproductqty.text = arr_product_quantity[indexPath.row]
            let url = URL(string: arr_product_image[indexPath.row])
            cell.proimageview.af.setImage(withURL: url!)
        }
        return cell
        
    }
   func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
      
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searcharrname = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searcharrid = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searcharrdetails = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searcharrprice = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searcharrquantity = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searcharrimage = arr_product_name.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
       
        
       // if(searcharrname.count > 0)
       // {
        //    self.searcharrid = arr_product_id
        //    self.searcharrdetails = arr_product_details
         //   self.searcharrprice = arr_product_price
          //  self.searcharrquantity = arr_product_quantity
       // }
       
        // searcharrprice = arr_product_price.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        is_searching = true
        ProductListTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        is_searching = false
        searchBar.text = ""
        ProductListTableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let main = storyboard?.instantiateViewController(identifier: "AddtocartViewController") as? AddtocartViewController{
//        main.product_id = arr_product_id[indexPath.row]
//        main.product_name = arr_product_name[indexPath.row]
//        main.product_price = arr_product_price[indexPath.row]
//        main.productdetails = arr_product_details[indexPath.row]
//        main.imageview = arr_product_image[indexPath.row]
//        self.navigationController?.pushViewController(main, animated: true)
//    }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        API_ListProduct()
        ProductListTableView.dataSource = self
        ProductListTableView.delegate = self
        MyProductSearchbar.delegate = self
        self.ProductListTableView.reloadData()
        lblsubcatid.text = sub_category_id
        lblsubcatid.isHidden = true
       }

    func API_ListProduct(){
        let url = "https://jigar.in/myapi/atecom1/api/api-view-product.php?sub_category_id=\(sub_category_id)"
        AF.request(url).responseJSON{(response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try? JSON(data: response.data!)
                print(myresult!["product_list"])
                let resultArray = myresult!["product_list"]
                print(resultArray["product_list"])
                
                self.arr_product_id.removeAll()
                self.arr_product_name.removeAll()
                self.arr_product_details.removeAll()
                self.arr_product_price.removeAll()
                self.arr_product_quantity.removeAll()
                self.arr_product_image.removeAll()

                for i in resultArray.arrayValue{
                    let product_id = i["product_id"].stringValue
                    self.arr_product_id.append(product_id)
                    
                    let product_name = i["product_name"].stringValue
                    self.arr_product_name.append(product_name)
                    
                    let product_details = i["product_details"].stringValue
                    self.arr_product_details.append(product_details)
                    
                    let product_price = i["product_price"].stringValue
                    self.arr_product_price.append(product_price)
                    
                    let product_quantity = i["product_quantity"].stringValue
                    self.arr_product_quantity.append(product_quantity)
                    
                    let product_image = i["product_image"].stringValue
                    self.arr_product_image.append(product_image)
                    
                    print(product_id)
                    print(product_name)
                    print(product_details)
                    print(product_price)
                    print(product_quantity)
                    print(product_image)
                }
                self.ProductListTableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }
}


