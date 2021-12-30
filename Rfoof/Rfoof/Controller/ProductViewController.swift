//
//  ProductViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 29/12/2021.
//

import UIKit
import Firebase

class ProductViewController: UIViewController {
    var selectedProduct : Product?
    var selectedProductImage: UIImage?
    
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    
    
    @IBOutlet weak var productTitleTextField: UITextField!
    
    @IBOutlet weak var productDescriptionTextField: UITextField!
    
    @IBOutlet weak var productPriceTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    

}
