//
//  ForgotViewController.swift
//  CategoryListApi
//
//  Created by Apple on 14/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ForgotViewController: UIViewController {

    @IBOutlet weak var TxtUserEmail: UITextField!

    @IBAction func BtnForgotpassword(_ sender: Any) {
        API_ForgotPassword()
        let main = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    func API_ForgotPassword(){
        var id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-user-forgot-password.php"
        let param:Parameters = ["user_email":TxtUserEmail.text!]
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
