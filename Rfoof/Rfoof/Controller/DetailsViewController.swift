//
//  DetailsViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 29/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {

  
    var selectedProduct : Product?
    var selectedProductImage:UIImage?
    

    
    
    @IBOutlet weak var ProductImageView: UIImageView!
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
   // _______________________________________
    
    // localization
    
    @IBOutlet weak var titleDetailsLabel: UILabel!
    
    @IBOutlet weak var descriptionDetailsLabel: UILabel!
    
    @IBOutlet weak var priceDetailsLabel: UILabel!
    
    
    @IBOutlet weak var numberDetailsLabel: UILabel!
    
    
    //----------------------------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // localization
        
        titleDetailsLabel.text = "Title".localized
        descriptionDetailsLabel.text = "Description".localized
        priceDetailsLabel.text = "price".localized
        numberDetailsLabel.text = "Number".localized
        
        
        
       //---------------------------------------
        

        if let selectedProduct = selectedProduct,
           let selectedImage = selectedProductImage {
            productTitleLabel.text = selectedProduct.title
            productDescriptionLabel.text = selectedProduct.description
            productPriceLabel.text = selectedProduct.price
            
            numberLabel.text = selectedProduct.user.number
            
            ProductImageView.image = selectedImage
            
        
    }
        
        
        
        // Do any additional setup after loading the view.
    }
    

   

}
