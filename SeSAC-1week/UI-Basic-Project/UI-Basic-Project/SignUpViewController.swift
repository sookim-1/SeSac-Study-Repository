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
        
        configureTextField()
        hiddenSwitch.setOn(false, animated: true)
    }
    
    func configureTextField() {
        emailTextField.placeholder = "이메일 주소 또는 전화번호"
        passwordTextField.placeholder = "비밀번호"
        nicknameTextField.placeholder = "닉네임"
        locationTextField.placeholder = "위치"
        referenceCodeTextField.placeholder = "추천 코드 입력"
        
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.keyboardType = .emailAddress
        referenceCodeTextField.keyboardType = .numberPad
        
        nicknameTextField.isHidden = true
        locationTextField.isHidden = true
        referenceCodeTextField.isHidden = true
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
    }
    
    @IBAction func switchHiddenTextField(_ sender: UISwitch) {
        if hiddenSwitch.isOn == true {
            nicknameTextField.isHidden = false
            locationTextField.isHidden = false
            referenceCodeTextField.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            locationTextField.isHidden = true
            referenceCodeTextField.isHidden = true
        }
    }
    
}
