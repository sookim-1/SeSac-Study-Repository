//
//  BaeminViewController.swift
//  UI-Basic-Project
//
//  Created by sookim on 2021/10/28.
//

import UIKit

class BaeminViewController: UIViewController {
    @IBOutlet var menuimageView1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchMenuButton))
        menuimageView1.addGestureRecognizer(tapGesture)
        menuimageView1.isUserInteractionEnabled = true
        
    }

    @objc func touchMenuButton() {
      print("hello")
    }
}
