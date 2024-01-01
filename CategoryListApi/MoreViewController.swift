//
//  MoreViewController.swift
//  CategoryListApi
//
//  Created by Apple on 03/11/23.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var lblnumber: UILabel!
    @IBAction func BtnAddfeedback(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "AddFeedbackViewController") as! AddFeedbackViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    @IBAction func BtnViewfeedback(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "ViewfeedbackViewController") as! ViewfeedbackViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func BtnViewWishlist(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "ViewwishlistViewController") as! ViewwishlistViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    @IBAction func BtnViewOrder(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "OrderlistTableViewController") as! OrderlistTableViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func Btneditprofile(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "ProfileeditViewController") as! ProfileeditViewController
        self.navigationController?.pushViewController(main, animated: true)
    }
    @IBAction func BTNLogin(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "uname")
        let main = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(main, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblnumber.text = UserDefaults.standard.string(forKey: "umobile")
        // Do any additional setup after loading the view.
    }
  
    
}
