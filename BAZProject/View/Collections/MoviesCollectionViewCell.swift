//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import UIKit

protocol MovieCollectionViewCellDelegate: AnyObject {
    func movieTapped(_ movie: Movie)
}

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    
    var movie: Movie?
    let detailMovie = DetailMovieViewController()
    weak var delegate: MovieCollectionViewCellDelegate?
    
     @IBOutlet weak var imgPosterPath: UIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configureCollection(with movie:Movie){
        self.movie = movie
        configureActionImageMovie()
        if let posterPath = movie.posterPath{
            imgPosterPath.setMovieImage(nameImage: posterPath)
        }
    }
    
    private func configureActionImageMovie(){
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imgPosterPath.addGestureRecognizer(tapGR)
        imgPosterPath.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(){
        guard let movie = movie else { return }
        delegate?.movieTapped(movie)
    }
}




 



