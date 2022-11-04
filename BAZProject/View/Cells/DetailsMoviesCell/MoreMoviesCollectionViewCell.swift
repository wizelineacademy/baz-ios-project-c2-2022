//
//  MoreMoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by mvazquezl on 01/11/22.
//

import UIKit

class MoreMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMoreMovies: UIImageView!
    @IBOutlet weak var lblTitleMoreMovies: UILabel!
    
    /// Setting of the detail of the movies for the cells
    func showDetailsMovies(movie: InfoMovies){
        lblTitleMoreMovies.text = movie.title
        if let posterPath = movie.posterPath {
            imgMoreMovies.setMovieImage(nameImage: posterPath )
        }
    }

}
