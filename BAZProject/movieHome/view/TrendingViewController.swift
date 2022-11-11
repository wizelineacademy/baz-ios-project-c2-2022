//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    var presenter: MoviewHomeViewToPresenterProtocol?
    let collectionViewFlowLayout: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 300, height: 180)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCollectionViewCell.self,forCellWithReuseIdentifier: MovieListCollectionViewCell.identefier)
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
        view.addSubview(collectionViewFlowLayout)
        collectionViewFlowLayout.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionViewFlowLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            collectionViewFlowLayout.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            collectionViewFlowLayout.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        //collectionViewFlowLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        collectionViewFlowLayout.heightAnchor.constraint(equalTo: collectionViewFlowLayout.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
}
