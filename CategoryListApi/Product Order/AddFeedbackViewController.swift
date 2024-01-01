//
//  AddFeedbackViewController.swift
//  CategoryListApi
//
//  Created by Apple on 14/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class AddFeedbackViewController: UIViewController {
   
    @IBOutlet weak var lbluserid: UILabel!
    @IBOutlet weak var Txtfeedbackrate: UITextField!
    @IBOutlet weak var Txtfeedbackdetails: UITextField!

    @IBAction func BtnAddfeedback(_ sender: Any) {
       
        API_Addfeedback()
        
        let main = storyboard?.instantiateViewController(identifier: "ViewfeedbackViewController") as! ViewfeedbackViewController
           self.navigationController?.pushViewController(main, animated: true)
        Txtfeedbackrate.text = ""
        Txtfeedbackdetails.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lbluserid.text = UserDefaults.standard.string(forKey: "uid")
       
    }
   func API_Addfeedback(){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        print(Txtfeedbackrate.text ?? String())
        print(Txtfeedbackdetails.text ?? String())
        let url = "https://jigar.in/myapi/ecom1/api/api-feedback-add.php"
        let param:Parameters = ["user_id":id!,
                                "feedback_rate":Txtfeedbackrate.text!,
                                "feedback_details":Txtfeedbackdetails.text!]
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
                }
                if flag == "0"{
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
