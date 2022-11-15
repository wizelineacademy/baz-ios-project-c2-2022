//
//  MovieListCollectionViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
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
        //viewStackVertical.addArrangedSubview(titleLabel)
        //viewStackVertical.addArrangedSubview(descriptionLabel)
        collectionViewStack.addArrangedSubview(imageView)
        //collectionViewStack.addArrangedSubview(viewStackVertical)
        
        
        /*NSLayoutConstraint.activate([
            viewStackVertical.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewStackVertical.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewStackVertical.topAnchor.constraint(equalTo: topAnchor)
        ])*/
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(model: Movie){
        imageView.loadFromNetwork(model.poster)
        //titleLabel.text = model.title
        //descriptionLabel.text = model.overview
    }
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
