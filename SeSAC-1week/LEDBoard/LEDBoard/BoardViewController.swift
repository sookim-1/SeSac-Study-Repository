//
//  ViewController.swift
//  LEDBoard
//
//  Created by sookim on 2021/10/30.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet var BoardView: UIView!
    @IBOutlet var ResultLabel: UILabel!
    @IBOutlet var SendButton: UIButton!
    @IBOutlet var TextColorButton: UIButton!
    @IBOutlet var UserTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        createDismissKeyboardTapGesture()
        UserTextField.delegate = self
    }

    @IBAction func sendToLabel(_ sender: UIButton) {
        ResultLabel.text = UserTextField.text
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        ResultLabel.textColor = getRandomColor()
    }
    
    func configure() {
        BoardView.layer.cornerRadius = 10
        
        UserTextField.layer.borderWidth = 0
        UserTextField.borderStyle = .none
        
        SendButton.layer.borderWidth = 5
        SendButton.layer.borderColor = UIColor.label.cgColor
        SendButton.layer.cornerRadius = 10
        SendButton.tintColor = .label
        
        TextColorButton.layer.borderWidth = 5
        TextColorButton.layer.borderColor = UIColor.label.cgColor
        TextColorButton.layer.cornerRadius = 10
        TextColorButton.tintColor = .systemRed
    }
    
    func getRandomColor() -> UIColor {
        let red : CGFloat = CGFloat.random(in: 0...1)
        let green : CGFloat = CGFloat.random(in: 0...1)
        let blue : CGFloat = CGFloat.random(in: 0...1)

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func exitTextField(_ sender: UITextField) {
        UserTextField.resignFirstResponder()
    }
}

extension BoardViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        UserTextField.resignFirstResponder()
//        return true
//    }
}
