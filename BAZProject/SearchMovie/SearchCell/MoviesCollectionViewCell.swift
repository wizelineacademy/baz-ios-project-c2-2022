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
    
    static let identifier = "movieCollection"
    let apiMovie = MovieAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(_ Element: Movie) {
        let posterImage = Element.posterPath ?? "poster"
        titleMovie.text = Element.title
        imageMovie.image = apiMovie.getImage(with: posterImage)
    }
}
