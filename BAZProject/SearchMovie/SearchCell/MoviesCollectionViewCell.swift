//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imgLiked: UIImageView!
    
    static let identifier = "movieCollection"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// setUpcell
    /// - Parameter movie: info about movie element
    /// - Parameter arrFavoritesMovies: Array with favorite movie id´s
    func setUpCell(_ movie: Movie, _ arrFavoriteMovies: [Int]) {
        let isFavoriteMovie = arrFavoriteMovies.contains(movie.id)
        let posterImage = movie.posterPath ?? "poster"
        titleMovie.text = movie.title
        ImageAPI.getImage(with: posterImage) { result in
            switch result {
            case .success(let image):
                self.imageMovie.image = image
            case .failure(_):
                self.imageMovie.image = UIImage(named: "poster")
            }
        }
        let imageLiked = isFavoriteMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.imgLiked.image = imageLiked
    }
}
