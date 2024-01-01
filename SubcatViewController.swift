//
//  SubcatViewController.swift
//  CategoryListApi
//
//  Created by Apple on 06/12/23.
//

import UIKit

class SubcatViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var CvSubCategory: UICollectionView!
    @IBOutlet weak var cat_id: UILabel!
    var collectioncategaory_id = ""
            override func viewDidLoad() {
            super.viewDidLoad()
            CvSubCategory.delegate = self
            CvSubCategory.dataSource = self
            fetch_sub_category_details()
            self.CvSubCategory.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
                
                cat_id.text = collectioncategaory_id
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return JSONField.arr_sub_cat_name.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! SubCategoryCell
            
            cell.subname.text = JSONField.arr_sub_cat_name[indexPath.row]
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 0.5
            //displya the image
            if let imageURL = URL(string: JSONField.arr_sub_cat_image[indexPath.row])
            {
                print(imageURL)
                DispatchQueue.global().async
                    {
                        let data = try? Data(contentsOf: imageURL)
                        if let data = data
                        {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                cell.subcatimageview.image = image
                            }
                        }
                }
            }
            
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("aaaaaaaaaaa")
        CvSubCategory.deselectItem(at: indexPath, animated: true)
        let product = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "product")as! product
        product.collesubcat_id  = JSONField.arr_sub_cat_id[indexPath.row]
        self.navigationController?.pushViewController(product, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 160 // You can adjust this based on your layout requirements
        let cellHeight: CGFloat = 170
        // Set the default height or calculate dynamically

           return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 20
    }
        func fetch_sub_category_details()
        {
            
            let url = URL(string:WEB_URL.SUB_CATEGORY_URL)
            do{
                let allmydata = try Data(contentsOf: url!)
                let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                
                if let arrayJson = adata["sub_category_list"] as? NSArray
                {
                    //when you again request for sub catefory the id will be clear for new request
                    JSONField.arr_sub_cat_id.removeAll()
                    JSONField.arr_sub_cat_name.removeAll()
                    JSONField.arr_sub_cat_image.removeAll()
                    
                    for index in 0...(adata["sub_category_list"]?.count)! - 1{
                        let object = arrayJson[index]as! [String:AnyObject]
                        
                        let sub_cat_IdJson = (object["sub_category_id"]as! String)
                        JSONField.arr_sub_cat_id.append(sub_cat_IdJson)
                        
                        let sub_cat_titleJson = (object["sub_category_name"]as! String)
                        JSONField.arr_sub_cat_name.append(sub_cat_titleJson)
                        
                        let sub_cat_imageJson = (object["sub_category_image"]as! String)
                        JSONField.arr_sub_cat_image.append(sub_cat_imageJson)
                    }
                }
                print("JSONField.arr_sub_cat_image : \(JSONField.arr_cat_image)")
            }
            catch
            {print("error:\(error)")
            }
        }
        
    }


