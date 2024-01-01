//
//  WEB_URL.swift
//  CategoryListApi
//
//  Created by Apple on 24/11/23.
//

import Foundation
import UIKit

class WEB_URL: UIViewController {
    
    static var MAIN_URL = "https://jigar.in/myapi/atecom1/api/"
    
    static var CATEGORIES_URL  = MAIN_URL + "api-view-category.php"
    
    static var  SUB_CATEGORY_URL = MAIN_URL + "api-subcategory-list.php"
    
    static var PRODUCTS_URL = MAIN_URL + "api-view-product.php?scatid="
}
