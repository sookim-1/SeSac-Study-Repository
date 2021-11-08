//
//  ViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentViewController(_ sender: UIButton) {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController")
        
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.modalPresentationStyle = .overFullScreen
        
        self.present(popUpViewController, animated: true)
    }
    
}

