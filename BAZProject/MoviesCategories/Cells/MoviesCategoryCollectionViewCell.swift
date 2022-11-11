//
//  MoviesCategoryCollectionViewCell.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 03/11/22.
//

import UIKit

final class MoviesCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imgLiked: UIImageView!
    
    
    static let identifier = "cellCollectionMovie"
    static let nameCell = "MoviesCategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// setUpcell
    /// - Parameter movie: info about movie element
    /// - Parameter arrFavoritesMovies: Array with favorite movie id´s 
    func setUpCell(_ movie: Movie, _ arrFavoritesMovies: [Int]) {
        let isLikeMovie = arrFavoritesMovies.contains(movie.id)
        let image = movie.posterPath ?? "poster"
        let imageLiked = isLikeMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        ImageAPI.getImage(with: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageMovie.image = image
                case .failure(_):
                    self.imageMovie.image = UIImage(named: "poster")
                }
            }
        }
        self.imgLiked.image = imageLiked
        self.titleMovie.text = movie.title
    }

}
