//
//  OrderplacedViewController.swift
//  CategoryListApi
//
//  Created by Apple on 11/10/23.
//

import UIKit

class OrderplacedViewController: UIViewController {

    @IBOutlet weak var vieworder: UIButton!
    @IBAction func BtnViewOrder(_ sender: Any) {
        let main = storyboard?.instantiateViewController(identifier: "OrderlistTableViewController") as! OrderlistTableViewController
        self.navigationController?.pushViewController(main, animated: true)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vieworder.backgroundColor = UIColor.green
        vieworder.layer.cornerRadius = 17.0
        vieworder.clipsToBounds = true
    }

}
