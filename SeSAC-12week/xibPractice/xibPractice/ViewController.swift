//
//  ViewController.swift
//  xibPractice
//
//  Created by sookim on 2021/12/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
    }


}

