//
//  ProductCell.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 29/12/2021.
//

import UIKit

class ProductCell: UITableViewCell {

    
    
    @IBOutlet weak var ProductImageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var ProductTitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(wiht product:Product) -> UITableViewCell {
        ProductTitleLabel.text = product.title
        userNameLabel.text = product.user.name
        
       
        
        
    
     
       
        return self
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        ProductImageView.image = nil
    }
    
    
    
    
}
