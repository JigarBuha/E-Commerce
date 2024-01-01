//
//  product.swift
//  
//
//  Created by Apple on 08/12/23.
//

import UIKit

class product: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionsubcategory_id: UILabel!
    var collesubcat_id = ""
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionView.dataSource = self
        ProductCollectionView.delegate = self
        fetch_product_details()
        self.ProductCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionsubcategory_id.text = collesubcat_id
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSONField.arr_product_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)as! ProductCell
        cell.Prolbl.text = JSONField.arr_product_name[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0.5
      
        
        if let imageURL = URL(string: JSONField.arr_product_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
            {
                let data = try? Data(contentsOf: imageURL)
                if let data = data
                {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.Proimage.image = image
                    }
                }
            }
        }
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ProductCollectionView.deselectItem(at: indexPath, animated: true)
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddtocartViewController")as! AddtocartViewController
     //   main.product_id = JSONField.arr_product_id[indexPath.row]
       // main.product_name = JSONField.arr_product_name[indexPath.row]
      //  main.product_price = JSONField.arr_product_price[indexPath.row]
       // main.productdetails = JSONField.arr[indexPath.row]
       // main.imageview = JSONField.arr_product_image[indexPath.row]
        self.navigationController?.pushViewController(main, animated: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 160 // You can adjust this based on your layout requirements
        let cellHeight: CGFloat = 170
        // Set the default height or calculate dynamically
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func fetch_product_details()
    {
        let url = URL(string:WEB_URL.PRODUCTS_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["product_list"] as? NSArray
            {
                for index in 0...(adata["product_list"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let catIdJson = (object["product_id"]as! String)
                    JSONField.arr_product_id.append(catIdJson)
                    
                    let catNameJson = (object["product_name"]as! String)
                    JSONField.arr_product_name.append(catNameJson)
                    
                    let catImageJson = (object["product_image"]as! String)
                    JSONField.arr_product_image.append(catImageJson)
                }
            }
            print("JSONField.arr_product_image : \(JSONField.arr_product_image)")
        }
        catch
        {print("error=\(error)")
        }
    }
    
}

