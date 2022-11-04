//
//  TrendingTableViewCell.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 26/10/22.
//
import UIKit
class TrendingTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imvPoster: UIImageView!
  
    private var movieAPI = MovieAPI()
    
    func getInfoCell(movie: Movie) {
        lblTitle.text = movie.title
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: movie.poster_path)) ?? UIImage(named: "poster")
        imvPoster.image = imageMovie
    }
}

