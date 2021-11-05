//
//  ViewController.swift
//  drinkWaterProject
//
//  Created by sookim on 2021/11/05.
//

import UIKit

class DrinkWaterViewController: UIViewController {
    @IBOutlet var currentWaterAmountTextField: UITextField!
    @IBOutlet var totalWaterAmountLabel: UILabel!
    @IBOutlet var recommendWaterAmountLabel: UILabel!
    
    var totalWaterAmount: Int = UserDefaults.standard.integer(forKey: "totalWaterAmount")

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        totalWaterAmountLabel.text = String(totalWaterAmount)
        getProfileData()
    }

    private func getProfileData() {
        guard let data = UserDefaults.standard.value(forKey: "profileModel") as? Data else { return }
        let profileModel = try? PropertyListDecoder().decode(ProfileModel.self, from: data)
        recommendWaterAmountLabel.text = "\(profileModel?.recommendWaterAmount())"
    }

    private func setNavigationBar() {
        self.title = "물 마시기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: nil)
    }

    @IBAction func drinkWater(_ sender: UIButton) {
        guard let currentWaterAmount = currentWaterAmountTextField.text,
              let currentAmount = Int(currentWaterAmount)
        else { return }

        totalWaterAmount += currentAmount
        UserDefaults.standard.set(totalWaterAmount, forKey: "totalWaterAmount")
        totalWaterAmountLabel.text = String(totalWaterAmount)
    }
}

