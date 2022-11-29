//
//  ReviewTableViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 24/11/22.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ReviewTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: ReviewTableViewCell.self), bundle: nil)
    }
    
    weak var delegate: ReviewCollectionSelectedProtocol? = nil
    var isModelMovies = false
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCollectionViewCell.self,forCellWithReuseIdentifier: MovieListCollectionViewCell.identefier)
        return collectionView
    }()
    
    var reviews: [Review] = []
    var movies: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollectionView()
    }
    
    /// This function dot not receive parameter setContraints
    /// - parameters
    private func initCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ReviewTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies.count > 0 {
            return movies.count
        }
        else if reviews.count > 0{
            return reviews.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identefier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        if isModelMovies {
            cell.configure(model: movies[indexPath.row], modelReview: nil)
            cell.layer.cornerRadius = 10
        }
        else {
            cell.configure(model: nil, modelReview: reviews[indexPath.row])
            cell.layer.cornerRadius = 105.0
        }
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if isModelMovies {
            delegate?.didSelectReview(at: indexPath, listReviews: self.movies)
        }
    }
}

extension ReviewTableViewCell {
    func setup(reviews: [Any], delegate: ReviewCollectionSelectedProtocol) {
        if let review = reviews as? [Review] {
            self.reviews = review
            self.movies = []
            isModelMovies = false
        }
        else if let movie = reviews as? [Movie] {
            self.movies = movie
            self.reviews = []
            isModelMovies = true
        }
        self.delegate = delegate
        collectionView.reloadData()
    }
    
}
