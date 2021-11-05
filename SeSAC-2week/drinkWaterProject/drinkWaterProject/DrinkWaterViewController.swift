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
    @IBOutlet var goalWaterAmountLabel: UILabel!
    
    var totalWaterAmount: Int = UserDefaults.standard.integer(forKey: "totalWaterAmount")
    var recommendWaterAmount: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        totalWaterAmountLabel.text = String(totalWaterAmount)
        getProfileData()
        refreshGoalWaterAmount(totalWaterAmount, recommendWaterAmount)
    }

    private func getProfileData() {
        guard let data = UserDefaults.standard.value(forKey: "profileModel") as? Data else { return }
        let profileModel = try? PropertyListDecoder().decode(ProfileModel.self, from: data)
        recommendWaterAmount = profileModel?.recommendWaterAmount()
        recommendWaterAmountLabel.text = "\(recommendWaterAmount)"
    }

    private func setNavigationBar() {
        self.title = "물 마시기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTotalWaterAmount))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(presentProfileViewController))
        refreshGoalWaterAmount(totalWaterAmount, recommendWaterAmount)
    }

    @IBAction func drinkWater(_ sender: UIButton) {
        guard let currentWaterAmount = currentWaterAmountTextField.text,
              let currentAmount = Int(currentWaterAmount)
        else { return }

        totalWaterAmount += currentAmount
        UserDefaults.standard.set(totalWaterAmount, forKey: "totalWaterAmount")
        totalWaterAmountLabel.text = String(totalWaterAmount)
    }
    
    @objc func presentProfileViewController() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func refreshTotalWaterAmount() {
        totalWaterAmount = 0
        UserDefaults.standard.set(totalWaterAmount, forKey: "totalWaterAmount")
        totalWaterAmountLabel.text = String(totalWaterAmount)
        
        refreshGoalWaterAmount(totalWaterAmount, recommendWaterAmount)
    }
    
    private func refreshGoalWaterAmount(_ totalWaterAmount: Int, _ recommendWaterAmount: Double?) {
        guard let recommendWaterAmount = recommendWaterAmount else { return }

        let literRecommendWaterAmount = recommendWaterAmount * 1000
        var goalWaterAmount = Int(round((Double(totalWaterAmount) / literRecommendWaterAmount) * 100))

        if goalWaterAmount > 100 {
            goalWaterAmount = 100
        }
        goalWaterAmountLabel.text = "목표의 \(goalWaterAmount)%"
    }
}

