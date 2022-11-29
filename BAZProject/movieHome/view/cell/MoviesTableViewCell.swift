//
//  MoviesTableViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 14/11/22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    static let identifier = String(describing: MoviesTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: MoviesTableViewCell.self), bundle: nil)
    }
    
    weak var delegate: MovieCollectionSelectedProtocol? = nil
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCollectionViewCell.self,forCellWithReuseIdentifier: MovieListCollectionViewCell.identefier)
        return collectionView
    }()
    
    private var movies: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollectionView()
    }
    
    
    /// Documentación
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
    
}

extension MoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identefier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: self.movies[indexPath.row], modelReview: nil)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectMovie(at: indexPath, listMovies: movies)
    }
}

extension MoviesTableViewCell {
    /// This function receive parameter setup
    /// - parameters
    ///      - movies: get Array of the movie
    ///      - delegate: get delegate for the select
    func setup(movies: [Movie], delegate: MovieCollectionSelectedProtocol) {
        self.movies = movies
        self.delegate = delegate
        collectionView.reloadData()
    }
    
    
}
