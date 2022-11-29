//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    var movie: Movie?
    
    @IBOutlet weak var movieDetailView: UIView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        moviePosterImage.layer.cornerRadius = 10.0
        moviePosterImage.layer.masksToBounds = true
        movieDetailView.layer.masksToBounds = false
        movieDetailView.layer.shadowColor = UIColor.gray.cgColor
        movieDetailView.layer.shadowOffset = CGSize(width: 0, height: 3)
        movieDetailView.layer.shadowOpacity = 0.3
        movieDetailView.backgroundColor = UIColor.clear
    }
    public func configureCollection(with movie:Movie){
        self.movie = movie
        if let posterPath = movie.posterPath{
            moviePosterImage.setMovieImage(nameImage: posterPath)
        }
    }
}




 



