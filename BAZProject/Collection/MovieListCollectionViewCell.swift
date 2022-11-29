//
//  MovieListCollectionViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import UIKit

class MovieListCollectionViewCell : UICollectionViewCell {
    static let identefier = "TrendingTableViewCell"
    
    
    private let collectionViewStack: UIStackView = {
        let staclView = UIStackView()
        return staclView.changePosition(position: .horizontal)
    }()
    private let viewStackVertical: UIStackView = {
        let viewStackVertical = UIStackView()
        return viewStackVertical.changePosition(position: .vertical)
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView.styleImage()
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 14)
        return titleLabel.styleLabel()
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 12)
        return descriptionLabel.styleLabel()
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(collectionViewStack)
        collectionViewStack.addArrangedSubview(imageView)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// This function receive parameter model and modelReview
    /// - parameters
    ///      - model: set model Movie
    ///      - modelReview:set model Review
    func configure(model: Movie?, modelReview: Review?){
        if let models = model {
            imageView.loadFromNetwork(models.posterPath)
        }
        else if let modelReviews = modelReview {
            imageView.loadFromNetwork(modelReviews.authorDetails?.avatarPath)
        }
    }
    /// This function receive parameter viewController and UiTabNarController
    /// - parameters
    ///      - tabBar: set tabBar for the navigation
    ///      - viewController: get ViewController current
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionViewStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1),
            collectionViewStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 1),
            collectionViewStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -1),
            collectionViewStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -1),
            
            imageView.topAnchor.constraint(equalTo: collectionViewStack.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: collectionViewStack.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: collectionViewStack.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: collectionViewStack.bottomAnchor)
        ])
    }
}
