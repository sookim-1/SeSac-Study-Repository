//
//  ViewController.swift
//  UI-Basic-Project
//
//  Created by sookim on 2021/10/28.
//

import UIKit

class NetflixViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var subImageView1: UIImageView!
    @IBOutlet var subImageView2: UIImageView!
    @IBOutlet var subImageView3: UIImageView!
    
    var randomNum: [Int] = []
    
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
    
    @IBAction func clickRandomButton(_ sender: UIButton) {
        randomNum.removeAll()
        randomNum.append(Int.random(in: 1...10))

        // 중복제거
        while randomNum.count != 4 {
            let tempNumber = Int.random(in: 1...10)
            
            if randomNum.contains(tempNumber) == false {
                randomNum.append(tempNumber)
            }
        }
        
        mainImageView.image = UIImage(named: "poster\(randomNum[0])")
        subImageView1.image = UIImage(named: "poster\(randomNum[1])")
        subImageView2.image = UIImage(named: "poster\(randomNum[2])")
        subImageView3.image = UIImage(named: "poster\(randomNum[3])")
    }

}

