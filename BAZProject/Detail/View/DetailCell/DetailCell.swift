//
//  DetailCell.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 08/11/22.
//

import UIKit

class DetailCell: UICollectionViewCell {
    @IBOutlet weak var imvDetail: UIImageView!
    // MARK: - Properties
    private var movieAPI = MovieAPI()
    
    /// Setting of the detail of the movies
    ///  - Parameters:
    ///  - movie: Movie object contains the values to show in the view
    func showDetailsMovies(movie: Movie) {
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: movie.posterPath)) ?? UIImage(named: "poster")
        imvDetail.image = imageMovie
    }
    /// Setting of the detail of the movies
    ///  - Parameters:
    ///  - cast: Cast object contains the values to show in the view
    func showCast(cast: Cast) {
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: cast.profilePath)) ?? UIImage(named: "poster")
        imvDetail.image = imageMovie
    }
}
