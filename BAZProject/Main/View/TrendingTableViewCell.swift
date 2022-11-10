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
    
    // MARK: - Properties
    private var movieAPI = MovieAPI()
    
    /// Movie information settings
    ///  - Parameters:
    ///  - movie: Movie object contains the values to show in the view
    func getInfoCell(movie: Movie) {
        lblTitle.text = movie.title
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: movie.posterPath)) ?? UIImage(named: "poster")
        imvPoster.image = imageMovie
    }
}

