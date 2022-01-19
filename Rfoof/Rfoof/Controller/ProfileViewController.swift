//
//  ProfileViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import Foundation
import UIKit

import Firebase

class ProfileViewController: UIViewController {

   let imagePickerController = UIImagePickerController()
    let activityIndicator = UIActivityIndicatorView()
    var selectedAccount : User?
    var selectedAccountImage : UIImage?
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!{
    
    didSet{
        profileImageView.layer.borderColor = UIColor.systemYellow.cgColor
        profileImageView.layer.borderWidth = 3.0
      
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        
        profileImageView.layer.masksToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        
           
    
        
        
    }
    
    }
    
    
    
   
    @IBOutlet weak var nameUserLabel: UILabel!
    
    @IBOutlet weak var numberUserLabel: UILabel!
    
    
   // ---------------------------------------------------------------
    
 //   loclization
    
    @IBOutlet weak var nameProfileLabel: UILabel!
    
    
    @IBOutlet weak var numberProfileLabel: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    
    //----------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrenUserData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "backButton".localized, style: .plain, target: nil, action: nil)
        
        editProfileBtn.layer.cornerRadius = 15
        
    
        
       getCurrenUserData()
        
        //-----------------------------------------
        
        nameProfileLabel.text = "Name".localized

        numberProfileLabel.text = "Number".localized
        
        editProfileBtn.setTitle("Edit".localized, for: .normal)
       //-----------------------------------------

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editprofileButton(_ sender: Any) {
        
        
    }
    

    
    func getCurrenUserData() {
        let refrance = Firestore.firestore()

        if let currentUser = Auth.auth().currentUser {
            let currentUserId = currentUser.uid

            refrance.collection("users").document(currentUserId).getDocument {
                userSnapshot,error in
                if let error = error {
                    print("ERROR geting current user snapshot",error.localizedDescription)
                }else {
                    if let userSnapshot = userSnapshot {
                        let userData = userSnapshot.data()
                        if let userData = userData {
                            let currentUserData = User (idct: userData)
                            DispatchQueue.main.async {
                                self.nameUserLabel.text = currentUserData.name
                                self.numberUserLabel.text = currentUserData.number
                                self.profileImageView.loadImageUsingCache(with: currentUserData.imageUrl)

                            }
                        } else {
                            print("User data not found or not the same !!!!")
                        }
                    }
                }
            }
        }
    }


}






