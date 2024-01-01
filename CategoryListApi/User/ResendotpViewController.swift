//
//  ResendotpViewController.swift
//  CategoryListApi
//
//  Created by Apple on 13/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ResendotpViewController: UIViewController {

    @IBOutlet weak var lblUserMobile: UILabel!
    @IBOutlet weak var TxtEnterOtp: UITextField!
    @IBAction func Btnverifyandproceed(_ sender: Any) {
        API_OtpVerify()
    }
 
    @IBOutlet weak var Btnresend: UIButton!
    @IBAction func BtnResendotp(_ sender: Any) {
        API_OtpReSend()
        mytimer.invalidate()
        mytime = 10
        lblTimer.text = ("10")
        
        mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.myaction), userInfo: nil, repeats: true)
    }
    @objc func myaction()
    {
        lblTimer.text = String(mytime)
        if self.mytime > 0
            
        {
            self.mytime -= 1
        }
        else{
            mytimer.invalidate()
        }
    }
    func btn(){
        if(mytime == 10){
            Btnresend.isHidden = true
        }else if(mytime == 0){
            Btnresend.isHidden = false
        }else{
            
        }
    }
    @IBOutlet weak var lblTimer: UILabel!
    var mytime = 10
    var mytimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserMobile.text = UserDefaults.standard.string(forKey: "usermobile")
        mytimer.invalidate()
        mytime = 10
        lblTimer.text = ("10")
        
        mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.myaction), userInfo: nil, repeats: true)
        btn()
    }
    override func viewWillAppear(_ animated: Bool) {
        btn()
    }
    func API_OtpReSend(){
        let id = UserDefaults.standard.string(forKey: "uid")
        // print(id!)
        let url = "https://jigar.in/myapi/atecom1/api/api-resend-otp.php"
        let param:Parameters = ["user_mobile":lblUserMobile.text!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
               
                self.btn()
                break
            case .failure:
                break
            }
        }
        
    }
    func API_OtpVerify(){
        let id = UserDefaults.standard.string(forKey: "uid")
       // print(id!)
       let url = "https://jigar.in/myapi/atecom1/api/api-verify-otp.php"
        let param:Parameters = ["user_mobile":lblUserMobile.text!,
                                "mobile_otp":TxtEnterOtp.text!]
       AF.request(url, method: .post, parameters: param).responseJSON{
           (response) in
           switch response.result{
           case .success:
               let responseData = JSON(response.data!)
               print(responseData)
               let flag = responseData["flag"].stringValue
             //  let message = responseData["message"].stringValue
               if flag == "1"{
                 
                  if(id == UserDefaults.standard.string(forKey: "uid")){
                       let main = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                       self.navigationController?.pushViewController(main, animated: true)
                   }else{
                       let loginalert = UIAlertController(title: "OTP", message: "Wrong Otp", preferredStyle: .alert)
                       let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                       loginalert.addAction(ok)
                       self.present(loginalert,animated: true, completion: nil)
                      
                   }
               }
               
               break
           case .failure:
               break
           }
       }
       
   }
}






/*   func otp(){
       let pref = UserDefaults.standard
       let otp = pref.object(forKey: "uotp")
       if(otp != nil){
           if(TxtEnterOtp.text! == otp! as? String){
             print("confirm otp")
               let main = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
               self.navigationController?.pushViewController(main, animated: true)
           }else{
               let loginalert = UIAlertController(title: "otp", message: "wrong otp", preferredStyle: .alert)
               let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
               loginalert.addAction(ok)
               self.present(loginalert,animated: true, completion: nil)
               }
        }
   }*/
