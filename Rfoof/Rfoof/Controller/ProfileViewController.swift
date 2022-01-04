//
//  ProfileViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit

import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
   
    @IBOutlet weak var nameUpdateTextField: UITextField!
    
    
    @IBOutlet weak var numberUpdateTextField: UITextField!
    
    
    
    
    
   // ---------------------------------------------------------------
    
    
    @IBOutlet weak var nameProfileLabel: UILabel!
    
    
    @IBOutlet weak var numberProfileLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  getCurrenUserData()
        
//        nameProfileLabel.text = "".localized
//        ddescriptionLabel.text = "".localized
//        numberProfileLabel.text = "".localized
//        
        
        

        // Do any additional setup after loading the view.
    }
    
//    func getCurrenUserData () {
//        let refrance = Firestore.firestore()
//
//        if let currentUser = Auth.auth().currentUser {
//            let currentUserId = currentUser.uid
//
//            refrance.collection("users").document(currentUserId).getDocument {
//                userSnapshot,error in
//                if let error = error {
//                    print("ERROR geting current user snapshot",error.localizedDescription)
//                }else {
//                    if let userSnapshot = userSnapshot {
//                        let userData = userSnapshot.data()
//                        if let userData = userData {
//                            let currentUserData = User (idct: userData)
//                            DispatchQueue.main.async {
//                                self.userNameLabel.text = currentUserData.name
//                                self.userNumberLabel.text = currentUserData.number
//
//                            }
//                        } else {
//                            print("User data not found or not the same !!!!")
//                        }
//                    }
//                }
//            }
//        }
//    }
//

}
