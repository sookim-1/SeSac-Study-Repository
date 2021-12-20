//
//  BeerInformationViewController.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import UIKit

class BeerInformationViewController: UIViewController {

    enum Section {
        case main
    }
    
    var beername: String!
    var beers: [Beer] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Beer>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getBeers()
        configureDataSource()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: BeerCollectionViewCell.reuseID)
    }
    
    func getBeers() {
        NetworkManager.shared.getBeers(for: beername, page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let beers):
                self.beers = beers
                self.updateData()
                
            case .failure(let error):
                print("정보가져오기 에러")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Beer>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, beer) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.reuseID, for: indexPath) as! BeerCollectionViewCell
            cell.set(beer: beer)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Beer>()
        snapshot.appendSections([.main])
        snapshot.appendItems(beers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
