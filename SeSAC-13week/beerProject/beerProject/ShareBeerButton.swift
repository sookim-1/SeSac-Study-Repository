//
//  ShareBeerButton.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import UIKit

class ShareBeerButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title
         : String) {
        super.init(frame: .zero)
        self.backgroundColor = .systemMint
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
