//
//  MovieListTableViewCell.swift
//  BAZProject
//
//  Created by 1030364 on 04/11/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieView.layer.cornerRadius = 10.0
        posterImage.layer.cornerRadius = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieListTableViewCell", bundle: nil)
    }
    
    func configureCell(movie: MovieModel) {
        title.text = movie.movie.title
        subtitle.text = String(movie.movie.voteAverage ?? 0.0)
        posterImage.image = movie.moviePoster
    }
    
}
