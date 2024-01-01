//
//  ViewController.swift
//  CategoryListApi
//
//  Created by Apple on 02/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import PasswordTextField

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Txtuseremail: UITextField!
    @IBOutlet weak var Txtuserpassword: UITextField!
    
    @IBAction func BtnGetOtp(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "OtpsendViewController") as! OtpsendViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func BtnForgotPassword(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "ForgotViewController") as! ForgotViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func BtnNewAccount(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "SingnupViewController") as! SingnupViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBOutlet weak var btnlogin: UIButton!
    @IBAction func Btnlogin(_ sender: Any) {
        if validate{
            API_Login()
        }
       // check()
        let main = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(main, animated: true)
        _ = SweetAlert().showAlert("Login Successfully!")
        Txtuseremail.text = ""
        Txtuserpassword.text = ""
        loginUser()
        
    }
    func loginUser() {
          // Perform the login logic here
          
          // Assuming the login is successful
          let homeViewController = HomeViewController()
          
          // Present the home view controller modally
          homeViewController.modalPresentationStyle = .fullScreen
          present(homeViewController, animated: true, completion: nil)
      }
    @IBOutlet weak var lblemail: UILabel!
    @IBAction func TxtEmailValidation(_ sender: Any) {
        if let el = Txtuseremail.text {
                 if let e = emailinvalidate(email: el)
                 {
                     lblemail.isHidden = false
                     lblemail.text = e
                 }
                 else
                 {
                     lblemail.isHidden = true
                 }
             }
    }
    func emailinvalidate(email:String) -> String?
      {
          let pattern = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
          let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [pattern])
       let isValidEmailAddress = predicate.evaluate(with: email)
          if isValidEmailAddress == false
          {
              return "email not valid"
          }
        return nil
      }
    
    func check(){
        let pref = UserDefaults.standard
        let uemail = pref.object(forKey: "uemail")
        let upassword = pref.object(forKey: "upassword")
        if (uemail != nil && upassword != nil){
            if(Txtuseremail.text == uemail! as? String && Txtuserpassword.text == upassword! as? String){
                print("Loginin..")
                let main = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(main, animated: true)
            }
            else{
                let loginalert = UIAlertController(title: "log in", message: "log in failed", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                loginalert.addAction(ok)
                self.present(loginalert,animated: true, completion: nil)
                
            }
        }
        else{
           print("user not found")
        }
    }
    var validate:Bool{
          if Txtuseremail.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
              let alert = UIAlertController(title: "Message", message: "Please Enter Email", preferredStyle: .alert)
              let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
              alert.addAction(ok)
              self.present(alert, animated: true, completion: nil)
          }
          if Txtuserpassword.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
              let alert = UIAlertController(title: "Message", message: "Please Enter Password", preferredStyle: .alert)
              let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
              alert.addAction(ok)
              self.present(alert, animated: true, completion: nil)
              return false
          }
          return true
      }
    override func viewDidLoad() {
        super.viewDidLoad()
     //  open()
        btnlogin.backgroundColor = UIColor.green
        btnlogin.layer.cornerRadius = 17.0
        btnlogin.clipsToBounds = true
    }
    
   /* func open(){
        if(btnlogin.isExclusiveTouch){
            let main = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(main, animated: true)
        }else{
            let main = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(main, animated: true)
        }
    }*/
    var newurl = "https://jigar.in/myapi/atecom1/api/"
    func API_Login(){
        let url = newurl+"api-login.php"
        let param:Parameters = ["user_email":Txtuseremail.text!,
                                "user_password":Txtuserpassword.text!]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
                   
                   print(responseData["user_name"])
                    
                   let mobile = responseData["user_mobile"];
                   let mynewmobile = "\(mobile)"
                   print(mynewmobile)
                   let id = responseData["user_id"];
                   let mynewid = "\(id)"
                   print(mynewid)
                   let name = responseData["user_name"];
                   let mynewname = "\(name)"
                   print(mynewname)
                   let gender = responseData["user_gender"];
                   let mynewgender = "\(gender)"
                   print(mynewgender)
                    let email = responseData["user_email"];
                    let mynewemail = "\(email)"
                    print(mynewemail)
                    let address = responseData["user_address"];
                    let mynewaddress = "\(address)"
                    print(mynewaddress)
                    let photo = responseData["user_photo"];
                    let mynewphoto = "\(photo)"
                    print(mynewphoto)
                   //ID Save
                   UserDefaults.standard.set(mynewid, forKey: "uid")
                   UserDefaults.standard.set(mynewname, forKey: "uname")
                   UserDefaults.standard.set(mynewmobile, forKey: "umobile")
                   UserDefaults.standard.set(mynewgender, forKey: "ugender")
                   UserDefaults.standard.set(mynewemail, forKey: "uemail")
                   UserDefaults.standard.set(mynewaddress, forKey: "uaddress")
                   UserDefaults.standard.set(mynewphoto, forKey: "uphoto")
                   
                break
            case .failure:
                break
            }
        }
        
    }
   
}

