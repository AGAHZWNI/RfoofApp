//
//  Product.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 28/12/2021.
//

import Foundation

import Firebase

struct Product {
    var id = ""
    var userId = ""
    var title = ""
    var description = ""
    var imageUrl = ""
    var price = ""
    var user : User
    var createdAt : Timestamp?
    
    init (idct :[String:Any], id : String ,user : User){
        
   if let title = idct ["title"] as? String,
      let userId = idct ["userId"] as? String,
      let description = idct ["description"] as? String,
      let imageUrl = idct ["imageUrl"] as? String,
      let price = idct ["price"] as? String,
      let createdAt = idct ["createdAt"] as? Timestamp {
       self.userId = userId
       self.title = title
       self.description = description
       self.imageUrl = imageUrl
       self.price = price
       self.createdAt = createdAt
    }
        
        self.id = id
        self.user = user
        
}
}
