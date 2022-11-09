//
//  moviesCell.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import UIKit

protocol MoviesCellProtocol {
    func selectMovie(id: Int)
}

class MoviesCell: UITableViewCell {
    
    @IBOutlet weak var imgMovies: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var  moviesCellId: Int?
    static let idReusable: String = "MoviesCell"
    var moviesCellDelegate: MoviesCellProtocol?
    
    func configure(_ data: MovieEntity, moviesCellDelegate: MoviesCellProtocol) {
        self.imgMovies.loadImage(id: data.posterPath)
        self.lblTitle.text = data.title
        self.moviesCellId = data.id
        self.moviesCellDelegate = moviesCellDelegate
    }
    
    @IBAction func selectMovie(_ sender: Any) {
        if let delegate = self.moviesCellDelegate, let id = self.moviesCellId  {
            delegate.selectMovie(id: id)
        }
    }
}
