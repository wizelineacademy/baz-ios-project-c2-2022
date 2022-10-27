//
//  ContentMoviesTableViewCell.swift
//  BAZProject
//
//  Created by mvazquezl on 23/10/22.
//

import UIKit

class ContentMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMovies: UIImageView!
    @IBOutlet weak var lblTitleMovies: UILabel!
    @IBOutlet weak var lblSubtitleMovies: UILabel!
    
    /// Setting of the detail of the movies for the cells
    func showDetailsMovies(movie: InfoMovies){
        lblTitleMovies.text = movie.title
        lblSubtitleMovies.text  = movie.overview
        if let posterPath = movie.posterPath {
            imgMovies.setMovieImage(nameImage: posterPath )
        }
    }
}
