//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit
import SkeletonView
class MovieTableViewCell: UITableViewCell, GenericCellMovie {
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var originalTitleMovie: UILabel!
    @IBOutlet weak var qualificationMovie: UILabel!
    
    public var movieModel: Movie? {
        didSet { configure() }
    }
    
    private var movieViewModel = ViewModelMovie()
    
    func configureData(titulo: String, originalTitle: String, calificacion: Double, image: UIImage) {
        titleMovie.text = titulo
        originalTitleMovie.text = originalTitle
        qualificationMovie.text = "Calificacion: \(calificacion)"
        imageViewMovie.image = image
    }
    
    func setUpSkeleton() {
        imageViewMovie.isSkeletonable = true
        titleMovie.linesCornerRadius = 8
        originalTitleMovie.linesCornerRadius = 8
        qualificationMovie.linesCornerRadius = 8
        titleMovie.isSkeletonable = true
        originalTitleMovie.isSkeletonable = true
        qualificationMovie.isSkeletonable = true
    }
    
    func configure() {
        guard let movieModel = movieModel else { return }
        let imageMovie = UIImage(data: self.movieViewModel.getImage(urlImage: movieModel.posterPath)) ?? UIImage(named: "poster")
        self.configureData(titulo: movieModel.title, originalTitle: movieModel.originalTitle, calificacion: movieModel.voteAverage, image: imageMovie ?? UIImage())
    }
    
}
