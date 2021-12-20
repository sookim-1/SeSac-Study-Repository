//
//  BeerCollectionViewCell.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    static let reuseID = "BeerCollectionViewCell"
    
    let beerImageView = BeerImageView(frame: .zero)
    let beernameLabel = BeerTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(beer: Beer) {
        beernameLabel.text = beer.name
        beerImageView.downloadImage(from: beer.image_url)
    }
    
    private func configure() {
        addSubview(beerImageView)
        addSubview(beernameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            beerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            beerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            beerImageView.heightAnchor.constraint(equalTo: beerImageView.widthAnchor),
            beerImageView.widthAnchor.constraint(equalToConstant: 100),
            
            beernameLabel.topAnchor.constraint(equalTo: beerImageView.bottomAnchor, constant: 12),
            beernameLabel.leadingAnchor.constraint(equalTo: beerImageView.leadingAnchor, constant: padding),
            beernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            beernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
