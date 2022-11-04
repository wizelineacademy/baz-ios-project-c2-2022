//
//  SearchCell.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 04/11/22.
//

import UIKit

class SearchCell: UICollectionViewCell {
    @IBOutlet weak var imvPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var movieAPI = MovieAPI()
    
    func getInfoCollection(movie: Movie) {
        lblTitle.text = movie.title
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: movie.poster_path)) ?? UIImage(named: "poster")
        imvPoster.image = imageMovie
    }
}
