//
//  SearchCell.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 04/11/22.
//

import UIKit

struct SearchResultCellViewData {
    let title: String
    let posterPath: String
}

class SearchCell: UICollectionViewCell {
    @IBOutlet weak var imvPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var movieAPI = MovieAPI()
    
    /// Assign the values of the movie object to each of the cells
    /// 
    func getInfoCollection(movie: SearchResultCellViewData) {
        lblTitle.text = movie.title
        let imageMovie = UIImage(data: movieAPI.getImage(urlImage: movie.posterPath)) ?? UIImage(named: "poster")
        imvPoster.image = imageMovie
    }
}
