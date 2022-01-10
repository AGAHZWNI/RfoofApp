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
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
   
//    @IBOutlet weak var nameUpdateTextField: UITextField!
//    
//    
//    @IBOutlet weak var numberUpdateTextField: UITextField!
//    
//    
    @IBOutlet weak var nameUserLabel: UILabel!
    
    @IBOutlet weak var numberUserLabel: UILabel!
    
    
   // ---------------------------------------------------------------
    
    
    @IBOutlet weak var nameProfileLabel: UILabel!
    
    
    @IBOutlet weak var numberProfileLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
       getCurrenUserData()
        
//        nameProfileLabel.text = "".localized
//        ddescriptionLabel.text = "".localized
//        numberProfileLabel.text = "".localized
//        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editprofileButton(_ sender: Any) {
        
        
    }
    
//    @IBAction func handelEditAccount(_ sender: Any) {
//
//        if let image = profileImageView.image,
//           let imageData = image.jpegData(compressionQuality: 0.50),
//           let userName = nameUpdateTextField.text,
//
//            let numberUser = numberUpdateTextField.text,
//
//           let currentUser = Auth.auth().currentUser {
//
//            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
//
//            let storageRef = Storage.storage().reference(withPath: "User/\(currentUser.uid)")
//            let updloadMeta = StorageMetadata.init()
//            updloadMeta.contentType = "image/jpeg"
//            storageRef.putData(imageData, metadata: updloadMeta) {
//                StorageMetadata , error in
//                if let error = error {
//                    print("Upload error",error.localizedDescription)
//                }
//
//                storageRef.downloadURL{ url, error in
//                    var userData = [String:Any]()
//                    if let url = url {
//                        let db = Firestore.firestore()
//                        let ref = db.collection("users")
//                        userData = [
//                            "id": currentUser.uid,
//                            "name" : userName,
//                            "number" : numberUser,
//                     //      "email" : currentUser.email,
//                            "imageUrl" : url.absoluteString
//                        ]
//                        ref.document(currentUser.uid).setData(userData)
//                        { error in
//
//                   //         ref.document(productId).setData(productData) { error in
//                            if let error = error {
//                                print("FireStore Error",error.localizedDescription)
//
//                            }
//                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                    }
//
//            }
//        }
//
//    }
    
    
    
    
    
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


//extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//@objc func chooseImage() {
//    self.showAlert()
//}
//private func showAlert() {
//
//    let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
//    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
//        self.getImage(fromSourceType: .camera)
//    }))
//    alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
//        self.getImage(fromSourceType: .photoLibrary)
//    }))
//    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
//    self.present(alert, animated: true, completion: nil)
//}
////get image from source type
//private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
//
//    //Check is source type available
//    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
//
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = sourceType
//        self.present(imagePickerController, animated: true, completion: nil)
//    }
//}
//func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//    profileImageView.image = chosenImage
//    dismiss(animated: true, completion: nil)
//}
//func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    picker.dismiss(animated: true, completion: nil)
//}



