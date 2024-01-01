//
//  ChangepasswordViewController.swift
//  CategoryListApi
//
//  Created by Apple on 14/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ChangepasswordViewController: UIViewController {

    @IBOutlet weak var TxtOldPassword: UITextField!
    @IBOutlet weak var TxtNewPassword: UITextField!
    @IBOutlet weak var TxtConfirmPassword: UITextField!
    @IBAction func BtnChangePassword(_ sender: Any) {
        API_ChangePassword()
        let main = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func API_ChangePassword(){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-change-password.php"
        let param:Parameters = ["user_id":id!,
                                "opass":TxtOldPassword.text!,
                                "npass":TxtNewPassword.text!,
                                "cpass":TxtConfirmPassword.text!]
                                
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
