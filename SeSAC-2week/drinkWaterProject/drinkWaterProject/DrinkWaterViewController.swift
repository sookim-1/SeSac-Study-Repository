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
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var drinkWaterButton: UIButton!
    @IBOutlet var introduceLabel: UILabel!

    var totalWaterAmount: Int = UserDefaults.standard.integer(forKey: "totalWaterAmount")
    var recommendWaterAmount: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        totalWaterAmountLabel.text = "\(String(totalWaterAmount))ml"
        getProfileData()
        refreshGoalWaterAmount(totalWaterAmount, recommendWaterAmount)
        setInterfaceAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getProfileData()
    }

    private func setInterfaceAttribute() {
        introduceLabel.text = """
        잘하셨어요!
        오늘 마신양은
        """
        introduceLabel.textColor = .white
        totalWaterAmountLabel.textColor = .white
        goalWaterAmountLabel.textColor = .white
        recommendWaterAmountLabel.textColor = .white

        introduceLabel.font = .preferredFont(forTextStyle: .title2)
        introduceLabel.numberOfLines = 2
        totalWaterAmountLabel.font = .preferredFont(forTextStyle: .largeTitle)
        goalWaterAmountLabel.font = .preferredFont(forTextStyle: .body)
        recommendWaterAmountLabel.font = .preferredFont(forTextStyle: .body)

        currentWaterAmountTextField.backgroundColor = self.view.backgroundColor
        currentWaterAmountTextField.textColor = UIColor.white

        drinkWaterButton.setTitle("물 마시기", for: .normal)
        drinkWaterButton.backgroundColor = .white
        drinkWaterButton.tintColor = .black

    }

    private func getProfileData() {
        guard let data = UserDefaults.standard.value(forKey: "profileModel") as? Data else { return }
        let profileModel = try? PropertyListDecoder().decode(ProfileModel.self, from: data)
        recommendWaterAmount = profileModel?.recommendWaterAmount()
        let nickname = profileModel?.nickname
        recommendWaterAmountLabel.text = "\(nickname!)님의 하루 물 권장 섭취량은 \(recommendWaterAmount!)L입니다."
    }

    private func setNavigationBar() {
        let barAppearance = UINavigationBarAppearance()

        barAppearance.backgroundColor = UIColor(red: 79/255, green: 158/255, blue: 127/255, alpha: 1.0)
        self.navigationItem.standardAppearance = barAppearance
        self.navigationItem.scrollEdgeAppearance = barAppearance

        self.title = "물 마시기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTotalWaterAmount))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(presentProfileViewController))
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = UIColor(red: 79/255, green: 158/255, blue: 127/255, alpha: 1.0)
    }

    @IBAction func drinkWater(_ sender: UIButton) {
        guard let currentWaterAmount = currentWaterAmountTextField.text,
              let currentAmount = Int(currentWaterAmount)
        else { return }

        totalWaterAmount += currentAmount
        UserDefaults.standard.set(totalWaterAmount, forKey: "totalWaterAmount")
        totalWaterAmountLabel.text = "\(String(totalWaterAmount))ml"
    }
    
    @objc func presentProfileViewController() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func refreshTotalWaterAmount() {
        totalWaterAmount = 0
        UserDefaults.standard.set(totalWaterAmount, forKey: "totalWaterAmount")
        totalWaterAmountLabel.text = "\(String(totalWaterAmount))ml"
        
        refreshGoalWaterAmount(totalWaterAmount, recommendWaterAmount)
        goalWaterAmountLabel.textColor = .white
    }
    
    private func refreshGoalWaterAmount(_ totalWaterAmount: Int, _ recommendWaterAmount: Double?) {
        guard let recommendWaterAmount = recommendWaterAmount else { return }

        let literRecommendWaterAmount = recommendWaterAmount * 1000
        var goalWaterAmount = Int(round((Double(totalWaterAmount) / literRecommendWaterAmount) * 100))

        if goalWaterAmount > 100 {
            goalWaterAmount = 100
            goalWaterAmountLabel.textColor = .red
        }
        
        changeCharacterImage(currentGoalWaterAmount: goalWaterAmount)
        goalWaterAmountLabel.text = "목표의 \(goalWaterAmount)%"
    }
    
    private func changeCharacterImage(currentGoalWaterAmount: Int) {
        var imageNamed: String = "1-1"

        switch currentGoalWaterAmount {
        case 11..<22 :
            imageNamed = "1-2"
        case 22..<33 :
            imageNamed = "1-3"
        case 33..<44 :
            imageNamed = "1-4"
        case 44..<55 :
            imageNamed = "1-5"
        case 55..<66 :
            imageNamed = "1-6"
        case 66..<77 :
            imageNamed = "1-7"
        case 77..<88 :
            imageNamed = "1-8"
        case 88...100 :
            imageNamed = "1-9"
        default:
            imageNamed = "1-1"
        }

        characterImageView.image = UIImage(named: imageNamed)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentWaterAmountTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.currentWaterAmountTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
    }
}

