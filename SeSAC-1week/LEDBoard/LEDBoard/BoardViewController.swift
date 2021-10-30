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
        // Do any additional setup after loading the view.
    }

    @IBAction func sendToLabel(_ sender: UIButton) {
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
    }
    
}

