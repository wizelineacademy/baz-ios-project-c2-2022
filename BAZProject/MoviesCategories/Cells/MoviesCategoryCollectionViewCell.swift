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
    let apiMovie = ImageAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(_ movie: Movie, _ liked: Bool) {
        let image = movie.posterPath ?? "poster"
        let imageLiked = liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        apiMovie.getImage(with: image) { result in
            switch result {
            case .success(let image):
                self.imageMovie.image = image
            case .failure(_):
                self.imageMovie.image = UIImage(named: "poster")
            }
        }
        self.imgLiked.image = imageLiked
        self.titleMovie.text = movie.title
    }

}
