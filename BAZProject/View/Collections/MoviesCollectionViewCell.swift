//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    @IBOutlet weak var imgPosterPath: UIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configureCollection(with movie:Movie){
        print(movie)
        if let posterPath = movie.posterPath{
            imgPosterPath.setMovieImage(nameImage: posterPath)
        }
    }
}
