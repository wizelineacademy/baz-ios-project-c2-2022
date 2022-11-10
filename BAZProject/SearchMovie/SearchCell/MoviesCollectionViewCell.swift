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
    let imageApi = ImageAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(_ Element: Movie) {
        let posterImage = Element.posterPath ?? "poster"
        titleMovie.text = Element.title
        imageApi.getImage(with: posterImage) { result in
            switch result {
            case .success(let image):
                self.imageMovie.image = image
            case .failure(_):
                self.imageMovie.image = UIImage(named: "poster")
            }
        }
    }
}
