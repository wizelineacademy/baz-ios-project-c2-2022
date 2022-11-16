//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by 1017143 on 19/10/22.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var trashBtn: UIButton!
    private var movie: Movie?
    private var baseUrl: String?
     /// Assigns value to the visual elements of the CollectionViewCell from an object of type Movie.
     ///
     /// - Parameters:
     /// - movie: Object of type Movie contains the values to show in the view.
     /// - baseUrl:  String with url of image
    func setUpMovie(movie: Movie?, baseUrl: String?, showBin: Bool = false) {
        if let movie = movie,
           let baseUrl = baseUrl {
            self.movie = movie
            self.baseUrl = baseUrl
            self.trashBtn.isHidden = !showBin
        } else {
            debugPrint("Parameters Incomplete")
        }
    }
    /// Assign the values of the movie object to each of the cells
    func showMovie() {
        self.titleLbl.text = self.movie?.title
        self.subTitleLbl.text = self.movie?.originalTitle
        self.movieImageView.loadImage(urlStr: baseUrl ?? "")
    }
    /// Shadow the selected cell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
