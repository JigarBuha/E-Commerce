

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import PasswordTextField

class SingnupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
   
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtuseremail: UITextField!
    @IBOutlet weak var txtuserpassword: UITextField!
    @IBOutlet weak var txtusergender: UITextField!
    @IBOutlet weak var txtusermobileno: UITextField!
    @IBOutlet weak var Btnregisteroutlet: UIButton!
    @IBOutlet weak var txtuseraddress: UITextField!
    @IBAction func Btnregister(_ sender: Any) {
        if validate{
            API_SignUP()
         }
        
        let varname = txtusername.text
        let varemail = txtuseremail.text
        let varpassword = txtuserpassword.text
        let vargender = txtusergender.text
        let varmobileno = txtusermobileno.text
        let varaddress = txtuseraddress.text
        
        let pref = UserDefaults.standard
        pref.setValue(varname, forKey: "uname")
        pref.setValue(varemail, forKey: "uemail")
        pref.setValue(varpassword, forKey: "upassword")
        pref.setValue(vargender, forKey: "ugender")
        pref.setValue(varmobileno, forKey: "umobileno")
        pref.setValue(varaddress, forKey: "uaddress")
    }
    
    @IBAction func BtnSignin(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(main, animated: true)
        _ = SweetAlert().showAlert("Register Successfully!")
    }
    
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblmobile: UILabel!
    @IBAction func TxtEmailValidation(_ sender: Any) {
        if let el = txtuseremail.text {
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
    
    @IBAction func TxtMobileValidation(_ sender: Any) {
        if let mob = txtusermobileno.text {
               if let number = mobilenumber(value:  mob)
               {
                  lblmobile.isHidden = false
                  lblmobile.text = number
               }
           }
    }
    func mobilenumber(value:String) -> String?
      {
          let set = CharacterSet(charactersIn: value)
          
          if !CharacterSet.decimalDigits.isSuperset(of: set)
          {
              return "Enter only number"
          }
          if value.count != 10
          {
              return "mobile must be 10 digits"
          }
          if value.count >= 10
          {
              lblmobile.isHidden = true
          }
          return nil
      }
    
    var PickerData = ["Male","Female","Other"]
    let PickerView = UIPickerView()
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtusergender.text = PickerData[row]
        txtusergender.resignFirstResponder()
    }
    var validate:Bool{
        if txtusername.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if txtuseremail.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter Email", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if txtuserpassword.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter password", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if txtusergender.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter gender", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if txtusermobileno.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter mobileno", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if txtuseraddress.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please enter address", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PickerView.delegate = self
        self.PickerView.dataSource = self
        txtusergender.inputView = PickerView
        
        lblemail.isHidden = true
        lblmobile.isHidden = true
      //  Btnregisteroutlet.backgroundColor = UIColor.green
        Btnregisteroutlet.layer.cornerRadius = 17.0
        Btnregisteroutlet.clipsToBounds = true
    }
    func API_SignUP(){
       
        let url = "https://jigar.in/myapi/atecom1/api/api-signup.php"
        let param:Parameters = ["user_name":txtusername.text!,
                                "user_email":txtuseremail.text!,
                                "user_password":txtuserpassword.text!,
                                "user_gender":txtusergender.text!,
                                "user_mobile":txtusermobileno.text!,
                                "user_address":txtuseraddress.text!]
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
