//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import UIKit
class TrendingViewController: UIViewController {
    var presenter: MoviewHomeViewToPresenterProtocol?
    //var collectionViewProtocol: MovieCollectionViewCellProtocol?
    let collectionViewFlowLayout: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 300, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieHomeRouter.createModule(view: self)
        presenter?.callApiMoviesHomeData()
        initCollectionView()
        
    }
    
    func initCollectionView(){
        collectionViewFlowLayout.delegate = self
        collectionViewFlowLayout.dataSource = self
        collectionViewFlowLayout.register(MovieListCollectionViewCell.self,forCellWithReuseIdentifier: MovieListCollectionViewCell.identefier)
        view.addSubview(collectionViewFlowLayout)
        
        NSLayoutConstraint.activate([
            collectionViewFlowLayout.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionViewFlowLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewFlowLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewFlowLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
    }
}
