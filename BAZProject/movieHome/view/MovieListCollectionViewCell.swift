//
//  MovieListCollectionViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 08/11/22.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "TrendingTableViewCell"
    
    
    
    private let collectionViewStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.white.cgColor
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        imageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(collectionViewStack)
        collectionViewStack.addArrangedSubview(imageView)
        collectionViewStack.addArrangedSubview(titleLabel)
        NSLayoutConstraint.activate([
            collectionViewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewStack.topAnchor.constraint(equalTo: topAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(model: Movie){
        imageView.loadFromNetwork(model.poster)
        titleLabel.text = model.title
    }
}
