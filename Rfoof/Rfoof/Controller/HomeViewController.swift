//
//  HomeViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
var products = [Product]()
    var selectedProduct:Product?
    var selectedProductImage:UIImage?
    
    
    @IBOutlet weak var productTableView: UITableView!
        
    
//    didSet {
//        productTableView.delegate = self
//        productTableView.dataSource = self
//        productTableView.register(UINib(nibName: "productCell", bundle: nil)).addSnapshotListener { snapshot,error in if let error = error {
//
//        }
//
  //  }
    
  //  }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
