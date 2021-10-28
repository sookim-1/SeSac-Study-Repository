//
//  ViewController.swift
//  UI-Basic-Project
//
//  Created by sookim on 2021/10/28.
//

import UIKit

class NetflixViewController: UIViewController {

    @IBOutlet var subImageView1: UIImageView!
    @IBOutlet var subImageView2: UIImageView!
    @IBOutlet var subImageView3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cornerSubImageView(imageView: subImageView1)
        cornerSubImageView(imageView: subImageView2)
        cornerSubImageView(imageView: subImageView3)
    }

    func cornerSubImageView(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemRed.cgColor
    }
}

