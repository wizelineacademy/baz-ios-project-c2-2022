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
    
    
    let identifier = "cellCollectionMovie"
    let apiMovie = MovieAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(_ movie: Movie) {
        let image = movie.posterPath ?? "poster"
        self.imageMovie.image = apiMovie.getImage(with: image)
        self.titleMovie.text = movie.title
    }

}
