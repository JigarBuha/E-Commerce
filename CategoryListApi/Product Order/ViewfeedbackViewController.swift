//
//  ViewfeedbackViewController.swift
//  CategoryListApi
//
//  Created by Apple on 14/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ViewfeedbackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var MyTableView: UITableView!
    var arr_user_name = [String]()
    var arr_feedback_rate = [String]()
    var arr_feedback_date = [String]()
    var arr_feedback_details = [String]()
    var arr_feedback_id = [String]()
    var is_count = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_user_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! ViewfeedbackTableViewCell
        cell.lblusername.text = arr_user_name[indexPath.row]
        cell.lblfeedbackrate.text = arr_feedback_rate[indexPath.row]
        cell.lblfeedbackdateandtime.text = arr_feedback_date[indexPath.row]
        cell.lblfeedbackdetails.text = arr_feedback_details[indexPath.row]
        cell.lblfeedbackid.text = arr_feedback_id[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let deleteaction = UIAlertController(title: "View Feedback", message: "Your Record Here", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
        { (alert) in
            self.API_FeedbackRemove(feedback_id: self.arr_feedback_id[indexPath.row])
         
                let simpleaction = UIAlertController(title: "Delete", message: "Record Deleted", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                simpleaction.addAction(ok)
                self.present(simpleaction,animated: true ,completion: nil)
            }
            
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteaction.addAction(Delete)
            deleteaction.addAction(Cancel)
            self.present(deleteaction,animated: true,completion: nil)
        }
    }
  
    func checkData(){
        if self.is_count == false{
            let imageName = "timer.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 100, y:100, width: 100, height: 200)
            view.addSubview(imageView)
        }else
        {
            let imageName = "timer.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 0, y:0, width: 0, height: 0)
            view.addSubview(imageView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTableView.dataSource = self
        MyTableView.delegate = self
    
        API_ViewFeedback()
        userid.text = UserDefaults.standard.string(forKey: "uid")
        userid.isHidden = true
       
    }
    override func viewWillAppear(_ animated: Bool) {
        checkData()
    }

    func API_ViewFeedback(){
        let id = UserDefaults.standard.string(forKey: "uid")
        print(id!)
        let url = "https://jigar.in/myapi/ecom1/api/api-feedback-view.php"
        let param:Parameters = ["user_id":id!]
        AF.request(url, method: .post ,parameters: param).responseJSON{(response) in
            switch response.result{
            case .success:
                print(response.result)
                let myresult = try? JSON(data: response.data!)
                print(myresult!["feedback_list"])
                
                let resultArray = myresult!["feedback_list"]
                print(resultArray["feedback_list"])
                
                self.arr_user_name.removeAll()
                self.arr_feedback_rate.removeAll()
                self.arr_feedback_date.removeAll()
                self.arr_feedback_details.removeAll()
                self.arr_feedback_id.removeAll()
                
                for i in resultArray.arrayValue{
                    let user_name = i["user_name"].stringValue
                    self.arr_user_name.append(user_name)
                    
                    let feedback_rate = i["feedback_rate"].stringValue
                    self.arr_feedback_rate.append(feedback_rate)
                    
                    let feedback_date_time = i["feedback_date_time"].stringValue
                    self.arr_feedback_date.append(feedback_date_time)
                    
                    let feedback_details = i["feedback_details"].stringValue
                    self.arr_feedback_details.append(feedback_details)
                    
                    let feedback_id = i["feedback_id"].stringValue
                    self.arr_feedback_id.append(feedback_id)
                    
                    print(user_name)
                    print(feedback_rate)
                    print(feedback_date_time)
                    print(feedback_details)
                    print(feedback_id)
                    self.is_count = true
                    print(self.is_count)
                    
                }
                self.checkData()
                self.MyTableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }
    
    func API_FeedbackRemove(feedback_id:String){
        let url = "https://jigar.in/myapi/ecom1/api/api-feedback-delete.php"
        let param:Parameters = ["feedback_id":feedback_id]
        AF.request(url, method: .post, parameters: param).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
               print(responseData)
                break
            case .failure:
                break
            }
        }
      API_ViewFeedback()
    }
}
