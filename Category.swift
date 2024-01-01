//
//  CategoryCollectionViewController.swift
//  CategoryListApi
//
//  Created by Apple on 24/11/23.
//

import UIKit

class Category: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{
    
    var layout = UICollectionViewFlowLayout()
    @IBOutlet weak var cvProducts: UICollectionView!
    
//    var selected_cat_id = String()
    override func viewDidLoad() {
            super.viewDidLoad()
            cvProducts.reloadData()
            cvProducts.delegate = self
            cvProducts.dataSource = self
            fetch_categories_details()
       // layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        self.cvProducts.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        }
               
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSONField.arr_cat_name.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath)as! CategoryCell
        cell.Mylabel.text = JSONField.arr_cat_name[indexPath.row]
        cell.layer.borderColor = .none
        cell.layer.cornerRadius = 20.0
        //cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.5
        //cell.layer.borderColor = UIColor.lightGray.cgColor
       // let backgroundImage = UIImage(named: "blue bg")
       // let backgroundImageView = UIImageView(image: backgroundImage)
       // backgroundImageView.contentMode = .scaleAspectFill
       // cell.backgroundView = backgroundImageView
//        func randomColor() -> UIColor {
//               let red = CGFloat(drand48())
//               let green = CGFloat(drand48())
//               let blue = CGFloat(drand48())
//               
//               return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//           }
        
        if let imageURL = URL(string: JSONField.arr_cat_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.Myimageview.image = image
                        }
                    }
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("aaaaaaaaaaa")
        cvProducts.deselectItem(at: indexPath, animated: true)
        let subCate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubcatViewController")as! SubcatViewController
        subCate.collectioncategaory_id  = JSONField.arr_cat_id[indexPath.row]
        navigationController?.pushViewController(subCate, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 155 // You can adjust this based on your layout requirements
        let cellHeight: CGFloat = 160
        
        // Set the default height or calculate dynamically

           return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
  
    //for the fetch the category details
    func fetch_categories_details()
    {
        let url = URL(string:WEB_URL.CATEGORIES_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["category_list"] as? NSArray
            {
                for index in 0...(adata["category_list"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let catIdJson = (object["category_id"]as! String)
                    JSONField.arr_cat_id.append(catIdJson)
                    
                    let catNameJson = (object["category_name"]as! String)
                    JSONField.arr_cat_name.append(catNameJson)
                    
                    let catImageJson = (object["category_image"]as! String)
                    JSONField.arr_cat_image.append(catImageJson)
                }
            }
            print("JSONField.arr_cat_image : \(JSONField.arr_cat_image)")
        }
        catch
        {print("error=\(error)")
        }
    }
}
    
   


   

    

    
