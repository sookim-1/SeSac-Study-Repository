//
//  DetailViewController.swift
//  xibPractice
//
//  Created by sookim on 2021/12/14.
//

import UIKit

class DetailViewController: UIViewController {

    let bannerView = BannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        bannerView.frame = CGRect(x: 30, y: 100, width: UIScreen.main.bounds.width - 60, height: 120)
        view.addSubview(bannerView)
    }
    

}
