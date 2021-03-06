//
//  RegisterViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var userImageView: UIImageView!{
    
    didSet{
        
    
        userImageView.layer.borderColor = UIColor.systemYellow.cgColor
        
     //   self.userImageView.tintColor = UIColor.init(red: 242 / 255, green: 175 / 255, blue: 72 / 255, alpha: 1)
        
        
        
        userImageView.layer.borderWidth = 3.0
      
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        
        userImageView.layer.masksToBounds = true
        userImageView.isUserInteractionEnabled = true
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        userImageView.addGestureRecognizer(tabGesture)
        
            
    
        
        
    }
    
    }
    
    //localiztion
    
    @IBOutlet weak var nameRegisterLabel: UILabel!
    @IBOutlet weak var emailRegisterLabel: UILabel!
    @IBOutlet weak var passwoardRegisterLabel: UILabel!
    @IBOutlet weak var confirmRegisterLabel: UILabel!
    @IBOutlet weak var numberRegisterLabel: UILabel!
    
    @IBOutlet weak var registerButtn: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorRegessterLabel: UILabel!
    
    
   
    //-------------------------------------
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "backButton".localized, style: .plain, target: nil, action: nil)
        
        registerButtn.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 15
        
        imagePickerController.delegate = self
        
    //localization
        nameRegisterLabel.text = "Name".localized
        emailRegisterLabel.text = "Email".localized
        passwoardRegisterLabel.text = "Password".localized
        
        confirmRegisterLabel.text = "Confirm Password".localized
        
        numberRegisterLabel.text = "Number".localized
        
        
        registerButtn.setTitle("Register".localized, for: .normal)
        
        loginButton.setTitle("Login".localized, for: .normal)
        
       //---------------------------------------
        
      //  Kayboard
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
     //_____________________________________________________________________
        
        
        
    //    imagePickerController.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleRegister(_ sender: Any) {
        
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.50),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           let number = numberTextField.text,
           
            
            password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult,error in
                        
                if let error = error {
                    self.errorRegessterLabel.text = error.localizedDescription
                    
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                }
                
                
                
                
                
           //     print("with Result",authResult,authResult?.user.uid)
                
                if let error = error {
                    
                    print("Registration Auth Error" , error.localizedDescription)
                }
                
                
                
                if let authResult = authResult {
                   
                let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    
                    storageRef.putData(imageData, metadata: uploadMeta){storageMeta, error in
                        if let error = error {
                            print("Registration storage Error", error.localizedDescription)
                        }
                        storageRef.downloadURL {url,error in
                          
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData :[String:String] = [
                                    
                                    "id" : authResult.user.uid,
                                    "name" : name,
                                    "email" : email,
                                    "number" : number,
                                    "imageUrl" : url.absoluteString
                                
                                ]
                                
                                db.collection("users").document(authResult.user.uid).setData(userData) {error in
                                    if let error = error {
                                        print("Registration Database Error", error.localizedDescription)
                                    }else {
                                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController")as?UITabBarController {
                                            vc.modalPresentationStyle = .fullScreen
                                            
                                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                            
                                            self.present (vc,animated: true,completion: nil)
                                        }
                                    }
                                }
                            
                            }
                            
                        }
                    }
                        
                
                
                }
            }
        
    }else {
        if passwordTextField.text !=
            confirmRegisterLabel.text! {
            errorRegessterLabel.text =
            "PasswordnotCorecct".localized
            
        }else {
            errorRegessterLabel.text = "Empty"
        }
    }
    
    }

}

extension RegisterViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func selectedImage() {
     //   print("Abdulrahman")
        
        showAlert()
    
}
    func showAlert() {
        let alert = UIAlertController(title: "choose profile picture", message: "where do you want to pick your image from? ", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title:"camera".localized, style: .default){ Action in
            self .getImage(from:.camera)
        }
        let galaryAction = UIAlertAction(title: "Photo Album".localized, style: .default) { Action in
            self .getImage(from:.photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "cancle".localized, style: .default) { Action in
//            self .dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getImage (from sourceType : UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
           self.present(imagePickerController,animated: true, completion: nil)
    }
        
        
        
}
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {  return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
