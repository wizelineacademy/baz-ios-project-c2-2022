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

    
    func showDetailsMovies(movie: InfoMovies){
        lblTitleMovies.text = movie.title
        lblSubtitleMovies.text  = movie.overview
    }
}
