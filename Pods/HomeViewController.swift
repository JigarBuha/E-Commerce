//
//  HomeViewController.swift
//  CategoryListApi
//
//  Created by Apple on 10/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController,UIScrollViewDelegate{
    
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var pagecontrol: UIPageControl!
    var imageNames = ["banner1", "banner2", "banner3","banner4","banner5","banner6"]
    var imageViews: [UIImageView] = []
    let numberOfPages = 3
    var currentPage = 0
    var timer: Timer?
    
    @IBOutlet weak var lblUserName: UILabel!
    var arr_banner_image = [String]()
    var arr_banner_id = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = UserDefaults.standard.string(forKey: "uname")
        lblid.text = UserDefaults.standard.string(forKey: "uid")
        
        ScrollView.delegate = self
        ScrollView.isPagingEnabled = true
       // ScrollView.layer.cornerRadius = 17.0
        ScrollView.clipsToBounds = true
        Scroll()
    }
    func Scroll(){ for (index, imageName) in imageNames.enumerated() {
        let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * view.frame.width, y: 0, width: view.frame.width, height: ScrollView.frame.height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        ScrollView.addSubview(imageView)
        imageViews.append(imageView)
    }
        
        // Set up the page control
        pagecontrol.numberOfPages = imageNames.count
        pagecontrol.currentPage = 0
        
        // Set up timer for automatic scrolling
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    @objc func autoScroll() {
        let nextPage = (currentPage + 1) % imageNames.count
        let contentOffset = CGPoint(x: CGFloat(nextPage) * ScrollView.frame.width, y: 0)
        ScrollView.setContentOffset(contentOffset, animated: true)
        currentPage = nextPage
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pagecontrol.currentPage = Int(pageIndex)
    }
  
}
  
