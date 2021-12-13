//
//  ViewController.swift
//  xibPractice
//
//  Created by sookim on 2021/12/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView: UIView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(greenView)
        
        greenView.clipsToBounds = true
        greenView.alpha = 0.5
        
        redView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        blueView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        greenView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        blueView.backgroundColor = .blue
        
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
    }

    @IBAction func presentButtonClicked(_ sender: UIButton) {
        // 스토리보드를 사용하지않기 때문에 바로 화면전환 가능
        present(DetailViewController(), animated: true, completion: nil)
    }
    
}

