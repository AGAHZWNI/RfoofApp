//
//  LoginViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    //-------------------------------------
    
    @IBOutlet weak var emailLoginLabel: UILabel!
    
    @IBOutlet weak var passwordLoginLabel: UILabel!
    
    @IBOutlet weak var loginButtontwo: UIButton!
    
    @IBOutlet weak var registerButtonTwo: UIButton!
    
    //------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  Kayboard
          view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
          
       //_____________________________________________________________________
       
        
        //-------------------------------------
        emailLoginLabel.text = "Email".localized
        passwordLoginLabel.text = "Password".localized
        
        loginButtontwo.setTitle("Login".localized, for: .normal)
        
        registerButtonTwo.setTitle("Register".localized, for: .normal)
        
        //---------------------------------------

        // Do any additional setup after loading the view.
    }
    

    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
            
            let passwoad = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            
            Auth.auth().signIn(withEmail: email, password: passwoad) { authResult, error in
                
                if error == nil {
                    print ("Login succesfully")
                    
                }else {
                    print(error?.localizedDescription as Any)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    self.errorMessageLabel.text = error?.localizedDescription
                }
                
                
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UITabBarController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        
                        self.present(vc,animated: true,completion: nil)
                    }
                }
                
            }
        }
    
    }
    

}
