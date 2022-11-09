//
//  MainTableViewCell.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 03/11/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    
    func printData(movie: Movie) {
        titleLabel.text = movie.title
        getImage(movie: movie)
    }
    
    func getImage(movie: Movie) {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path) else { fatalError("Sorry, error") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async { [weak self] in
                self?.imageField.image = image
                self?.setNeedsLayout()
            }
        }
    }
}