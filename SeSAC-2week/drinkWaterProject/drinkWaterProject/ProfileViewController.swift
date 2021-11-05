//
//  ProfileViewController.swift
//  drinkWaterProject
//
//  Created by sookim on 2021/11/05.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setNavigationBar() {
        self.title = "물 마시기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveProfile))
    }


    @objc func saveProfile() {
        guard let nickname = nicknameTextField.text,
              let heightString = heightTextField.text,
              let height = Double(heightString),
              let weightString = weightTextField.text,
              let weight = Double(weightString) else { return }

        let profileModel = ProfileModel(nickname: nickname, height: height, weight: weight)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(profileModel), forKey: "profileModel")
    }

}
