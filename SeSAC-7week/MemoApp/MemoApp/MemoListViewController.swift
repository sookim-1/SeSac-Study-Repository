//
//  ViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class MemoListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentPopUpViewController()
        }
    }

    func presentPopUpViewController() {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController")
        
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.modalPresentationStyle = .overFullScreen
        
        self.present(popUpViewController, animated: true)
    }
    
}

