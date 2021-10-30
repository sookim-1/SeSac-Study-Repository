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
        createDismissKeyboardTapGesture()
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
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func clickSignUp(_ sender: UIButton) {
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text else { return }
        
        let trimWhiteSpaceEmailText = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimWhiteSpacePasswordText = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !trimWhiteSpaceEmailText.isEmpty && !trimWhiteSpacePasswordText.isEmpty {
            if trimWhiteSpacePasswordText.count < 6 {
                print("비밀번호 6자리이상입력해주세요")
            }
            else {
                successSignUpPrint()
            }
        }
        else {
            print("이메일 및 비밀번호를 기입하세요")
        }
    }
    
    func successSignUpPrint() {
        print("이메일 :" + emailTextField.text!)
        print("비밀번호 :" + passwordTextField.text!)
        print("닉네임 :" + nicknameTextField.text!)
        print("위치 :" + locationTextField.text!)
        print("추천코드 :" + referenceCodeTextField.text!)
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
