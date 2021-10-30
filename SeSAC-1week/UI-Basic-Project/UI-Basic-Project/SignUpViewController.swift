//
//  SignUpViewController.swift
//  UI-Basic-Project
//
//  Created by sookim on 2021/10/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var referenceCodeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var hiddenSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
    }
    
    @IBAction func switchHiddenTextField(_ sender: UISwitch) {
    }
    
}
