//
//  DetailTableViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 26/11/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var addFavoritesButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var movieStatusFavorite = false
    
    static func nib() -> UINib{
        return UINib(nibName: "DetailTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(movie: Movie) {
        guard let title = movie.title, let backdropPath = movie.backdropPath, let overview = movie.overview else { return}
        movieTitleLabel.text = title
        overviewTextView.text = overview
        movieImageView.setMovieImage(nameImage: backdropPath)
    }
    
    private func confgureButtonMovieFavorite() {
        addFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    @IBAction func addMovieFavorites(_ sender: Any) {
        
    }
    
    func removeMovieFavorite() {
        addFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func addMovieFavorite(){
        addFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}
