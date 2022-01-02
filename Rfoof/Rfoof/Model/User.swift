//
//  User.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 28/12/2021.
//

import Foundation


struct User {
    var id = ""
    var name = ""
    var email = ""
    var imageUrl = ""
    var number = ""
    
    init (idct : [String : Any]){
        if let id = idct ["id"] as? String,
           let name = idct ["name"] as? String,
            let email = idct ["email"] as? String,
           let imageUrl = idct ["imageUrl"] as? String,
           let number = idct ["number"] as? String {
           
            self.id = id
            self.name = name
            self.email = email
            self.imageUrl = imageUrl
            self.number = number
    }
}
}
