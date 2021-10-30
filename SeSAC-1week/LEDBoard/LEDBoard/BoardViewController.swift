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
    }

    @IBAction func sendToLabel(_ sender: UIButton) {
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
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
}

