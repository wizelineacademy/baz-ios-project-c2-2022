//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var tituloMovie: UILabel!
    @IBOutlet weak var originalTitleMovie: UILabel!
    @IBOutlet weak var calificacionMovie: UILabel!
    func configure(titulo: String, originalTitle: String, calificacion: Double, image: UIImage) {
        tituloMovie.text = titulo
        originalTitleMovie.text = originalTitle
        calificacionMovie.text = String(calificacion)
        imageViewMovie.image = image
    }

}
