//
//  ViewController.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 27/12/2021.
//

import UIKit

class LandingViewController: UIViewController {

    
    @IBOutlet weak var nameAppLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBOutlet weak var regesterButton: UIButton!
    
    
    @IBOutlet weak var loginButtn: UIButton!
    
    
    @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                case "fr":
                    languageSegmentControl.selectedSegmentIndex = 2
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         languageSegmentControl.selectedSegmentIndex = 2
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     languageSegmentControl.selectedSegmentIndex = 2
                 }else {
                     languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        regesterButton.setTitle("Register".localized, for: .normal)
        
        loginButtn.setTitle("login".localized, for: .normal)
        
        nameAppLabel.text = "Rfoof".localized
        
        welcomeLabel.text = "WELCOME".localized
        
        
        
      //  inmation
        
        
//        nameAppLabel.isHidden = true
//        welcomeLabel.isHidden = true
//
//        let tapGesture = UIGestureRecognizer(target: self, action: #selector(onClickView))
//        self.view.addGestureRecognizer(tapGesture)


        
        
//        nameAppLabel.text = "Rfoof".localized
//
//        welcomeLabel.text = "WELCOME".localized
//
        
//        regesterButton.setTitle("Register".localized, for: .normal)
//
//        loginButtn.setTitle("login".localized, for: .normal)
//
        //  sh
//        regesterButton.layer.cornerRadius = 2
//      //  btn.clipsToBounds = true
//
//        regesterButton.layer.shadowRadius = 10
//        regesterButton.layer.shadowOpacity = 1.0
//        regesterButton.layer.shadowOffset = CGSize(width: 3, height: 3)
//        regesterButton.layer.shadowColor = UIColor.black.cgColor
//
//        // sh 2
//
//        loginButtn.layer.cornerRadius = 2
//      //  btn.clipsToBounds = true
//
//        loginButtn.layer.shadowRadius = 10
//        loginButtn.layer.shadowOpacity = 1.0
//        loginButtn.layer.shadowOffset = CGSize(width: 3, height: 3)
//        loginButtn.layer.shadowColor = UIColor.green.cgColor
//
        
       // onClickView()
        
    }
    
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }

//
//    @objc
//        func onClickView() {
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.welcomeLabel.isHidden = false
//                self.welcomeLabel.transform = CGAffineTransform(translationX: 0, y: -120)
//
//            }) { ( _ ) in
//
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                    self.nameAppLabel.isHidden = false
//                    self.nameAppLabel.transform = CGAffineTransform(translationX: 0, y: -90)
//                }, completion : nil)
//
//                   // print(" Animation")
//
//
//
//
//
//                }
//
//
//
//}

        
}
