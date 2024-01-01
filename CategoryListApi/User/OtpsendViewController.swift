//
//  OtpsendViewController.swift
//  Pods
//
//  Created by Apple on 13/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class OtpsendViewController: UIViewController {

    @IBOutlet weak var TxtUserMobileno: UITextField!
    @IBAction func Btngetotp(_ sender: Any) {
        API_OtpSend()
        let main = storyboard?.instantiateViewController(identifier: "ResendotpViewController") as! ResendotpViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        var id = UserDefaults.standard.string(forKey: "uid")
        // Do any additional setup after loading the view.
    }

    func API_OtpSend(){
      
       let url = "https://jigar.in/myapi/atecom1/api/api-login-with-otp.php"
       let param:Parameters = ["user_mobile":TxtUserMobileno.text!]
       AF.request(url, method: .post, parameters: param).responseJSON{
           (response) in
           switch response.result{
           case .success:
               let responseData = JSON(response.data!)
               print(responseData)
             
               let flag = responseData["flag"].stringValue
               let message = responseData["message"].stringValue
               if flag == "1"{
                  
                   let mobile = responseData["user_mobile"];
                   let mynewmobile = "\(mobile)"
                   print(mynewmobile)
                   UserDefaults.standard.set(mynewmobile, forKey: "usermobile")
                
                  let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
                  let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
                      alert.addAction(ok)
                  self.present(alert,animated: true,completion: nil)
                   
                  }
                   else{
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
