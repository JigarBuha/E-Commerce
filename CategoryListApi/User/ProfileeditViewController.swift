//
//  ProfileeditViewController.swift
//  CategoryListApi
//
//  Created by Apple on 23/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ProfileeditViewController: UIViewController {
   
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var lbluserid: UILabel!
    @IBOutlet weak var Txtusergender: UITextField!
    @IBOutlet weak var Txtusername: UITextField!
    @IBOutlet weak var Txtuseremail: UITextField!
    @IBOutlet weak var Txtuseraddress: UITextField!
    @IBOutlet weak var Txtusermobileno: UITextField!
    var userid = ""
   // var imageview = ""
  
    @IBAction func Btnupdate(_ sender: Any) {
        API_ProfileUpdate()
        let main = storyboard?.instantiateViewController(identifier: "Category") as! Category
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func BtnChangePassword(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "ChangepasswordViewController") as! ChangepasswordViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lbluserid.text = userid
       // var url = URL(string: imageview)
       // self.MyImageView.af.setImage(withURL: url!)
       // url = UserDefaults.standard.string(forKey: "uphoto")
     
        Txtusername.text = UserDefaults.standard.string(forKey: "uname")
        Txtuseremail.text = UserDefaults.standard.string(forKey: "uemail")
        Txtusergender.text = UserDefaults.standard.string(forKey: "ugender")
        Txtuseraddress.text = UserDefaults.standard.string(forKey: "uaddress")
        Txtusermobileno.text = UserDefaults.standard.string(forKey: "umobileno")
    }
    func API_ProfileUpdate(){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-user-update.php"
        let param:Parameters = ["user_name":Txtusername.text!,
                                "user_email":Txtuseremail.text!,
                                "user_gender":Txtusergender.text!,
                                "user_address":Txtuseraddress.text!,
                                "user_mobile":Txtusermobileno.text!,
                                "user_id":id!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
                let flag = responseData["flag"].stringValue
                let message = responseData["message"].stringValue
                if flag == "1"{
                let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
                    alert.addAction(ok)
                self.present(alert,animated: true,completion: nil)
                }else{
                 let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
                 let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
                 alert.addAction(ok)
                 self.present(alert,animated: true,completion: nil)
                 
                 
             }
                break
            case .failure:
                break
            }
        }
        
    }
  
}

// API THROW DATA......

//func API_ProfileList(){
//    let id = UserDefaults.standard.string(forKey: "uid")
//    //print(id!)
//    let url = "https://jigar.in/myapi/atecom1/api/api-user-profile-detail.php?user_id=\(1)"
//    let param:Parameters = ["user_id":1]
//    AF.request(url, method: .post,parameters: param ).responseJSON{(response) in
//        switch response.result{
//        case .success:
//            let myresult = JSON(response.data!)
//            
//           // let U_photo = myresult["user_photo"].stringValue
//           // self.myimg.image = UIImage(named: U_photo)
//            let U_Name = myresult["user_name"].stringValue
//            self.name.text = U_Name
//            let U_Mobile = myresult["user_mobile"].stringValue
//            self.mobile.text = U_Mobile
//            let U_Email = myresult["user_email"].stringValue
//            self.email.text = U_Email
//            let U_Gender = myresult["user_gender"].stringValue
//            self.gender.text = U_Gender
//            let U_Address = myresult["user_address"].stringValue
//            self.address.text = U_Address
//        
//            break
//        case .failure:
//            break
//        }
//    }
//}
