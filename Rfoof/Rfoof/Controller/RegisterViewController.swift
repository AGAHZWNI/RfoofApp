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
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.layer.masksToBounds = true
        userImageView.isUserInteractionEnabled = true
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        userImageView.addGestureRecognizer(tabGesture)
        
            
    
        
        
    }
    
    }
    
    
    
    
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
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
        
                
           //     print("with Result",authResult,authResult?.user.uid)
                
                
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
        
        let cameraAction = UIAlertAction(title:"camera", style: .default){ Action in
            self .getImage(from:.camera)
        }
        let galaryAction = UIAlertAction(title: "Photo Album", style: .default) { Action in
            self .getImage(from:.photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "cancle", style: .default) { Action in
            self .dismiss(animated: true, completion: nil)
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
