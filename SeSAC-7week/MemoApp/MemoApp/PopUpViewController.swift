//
//  PopUpViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/09.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureLabel(label: welcomeLabel, text: "처음 오셨군요!\n환영합니다 :)")
        configureLabel(label: descriptionLabel, text: "당신만의 메모를 작성하고 관리해보세요!")
        configureButton()
    }
    
    func configureContainerView() {
        containerView.backgroundColor = .systemGray4
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
    }
    
    func configureLabel(label: UILabel, text: String) {
        label.text = text
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
    }
    
    func configureButton() {
        continueButton.setTitle("확인", for: .normal)
        continueButton.backgroundColor = .systemOrange
        continueButton.layer.cornerRadius = 10
        continueButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        continueButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
