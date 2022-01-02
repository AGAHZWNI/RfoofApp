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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameAppLabel.text = "".localized
        
        welcomeLabel.text = "".localized
        
        
        regesterButton.setTitle("Register".localized, for: .normal)
        
        loginButtn.setTitle("login".localized, for: .normal)
        
    }


}

