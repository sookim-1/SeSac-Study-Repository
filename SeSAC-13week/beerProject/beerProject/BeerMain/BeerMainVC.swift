//
//  BeerMainVC.swift
//  beerProject
//
//  Created by sookim on 2021/12/27.
//

import UIKit

class BeerMainVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - 하단 뷰
    private let footerView: UIView = {
        let fotterView = UIView()
        fotterView.translatesAutoresizingMaskIntoConstraints = false
        return fotterView
    }()
    
    private let resetBtn: UIButton = {
        let resetBtn = UIButton()
        
        resetBtn.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        resetBtn.layer.cornerRadius = 10
        resetBtn.layer.borderColor = UIColor.systemMint.cgColor
        resetBtn.layer.borderWidth = 2
        resetBtn.tintColor = .systemMint
        
        
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        return resetBtn
    }()
    
    private let shareBtn: UIButton = {
        let shareBtn = UIButton()
        shareBtn.backgroundColor = .systemMint
        shareBtn.layer.cornerRadius = 10
        shareBtn.setTitle("Share BEER", for: .normal)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        shareBtn.setTitleColor(.label, for: .normal)
        
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        return shareBtn
    }()
    
    // MARK: - 메인 스크롤뷰
    var scrollView: UIScrollView!
    var label: UILabel!
    var headerContainerView: UIView!
    var imageView: UIImageView!
    
    // MARK: - 스크롤 뷰 텍스트뷰
    var scrollDescriptionView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFooterView()
        configureScrollView()
        
    }
    
    func configureScrollView() {
        // ScrollView
        scrollView = UIScrollView()
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // Label
        label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        self.scrollView.addSubview(label)
        
        // Header Container
        headerContainerView = UIView()
        headerContainerView.backgroundColor = .gray
        self.scrollView.addSubview(headerContainerView)
        
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(imageView)
        
        // 설명 뷰
        scrollDescriptionView.layer.cornerRadius = 10
        scrollDescriptionView.backgroundColor = .systemBlue
        
        // ScrollView Constraints
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.footerView.topAnchor)
        ])
        
        // Label Constraints
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.label.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10),
            self.label.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 280)
        ])

        // Header Container Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true

        // ImageView Constraints
        let imageViewTopConstraint: NSLayoutConstraint!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)
        ])

        imageViewTopConstraint = self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
        
        // ScrollView
        scrollView.backgroundColor = UIColor.systemMint
        
        // Label Customization
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        // Set Image on the Header
        imageView.image = UIImage(systemName: "square.and.arrow.up")
    }
    
    func configureFooterView() {
        view.addSubview(footerView)
        footerView.addSubview(resetBtn)
        footerView.addSubview(shareBtn)
        let screenHeight = UIScreen.main.bounds.size.height
        
        resetBtn.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        shareBtn.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            resetBtn.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            shareBtn.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            resetBtn.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            resetBtn.trailingAnchor.constraint(equalTo: shareBtn.leadingAnchor, constant: -10),
            resetBtn.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10),
            resetBtn.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            
            resetBtn.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.15),
            
            shareBtn.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
            shareBtn.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10),
            shareBtn.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
        ])
    }

}
