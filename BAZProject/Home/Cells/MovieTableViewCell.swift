//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit
import SkeletonView

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var tituloMovie: UILabel!
    @IBOutlet weak var originalTitleMovie: UILabel!
    @IBOutlet weak var calificacionMovie: UILabel!
    
    public var movieModel: Movie? {
        didSet { configure() }
    }
    
    private var movieViewModel = ViewModelMovie()
    
    func configureData(titulo: String, originalTitle: String, calificacion: Double, image: UIImage) {
        tituloMovie.text = titulo
        originalTitleMovie.text = originalTitle
        calificacionMovie.text = "Calificacion: \(calificacion)"
        imageViewMovie.image = image
    }
    
    func setUpSkeleton() {
        imageViewMovie.isSkeletonable = true
        tituloMovie.linesCornerRadius = 8
        originalTitleMovie.linesCornerRadius = 8
        calificacionMovie.linesCornerRadius = 8
        tituloMovie.isSkeletonable = true
        originalTitleMovie.isSkeletonable = true
        calificacionMovie.isSkeletonable = true
    }
    
    private func configure() {
        guard let movieModel = movieModel else { return }
        let imageMovie = UIImage(data: self.movieViewModel.getImage(urlImage: movieModel.poster_path)) ?? UIImage(named: "poster")
        self.configureData(titulo: movieModel.title, originalTitle: movieModel.original_title, calificacion: movieModel.vote_average, image: imageMovie ?? UIImage())
    }
    
}
