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
    @IBOutlet weak var textField: UITextView!
    
    static let cellIdentifier: String = "cell"
    private let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    func printData(movie: Movie) {
        titleLabel.text = movie.title
        textField.text = movie.overview
        getImage(movie: movie)
    }
    
    func getImage(movie: Movie) {
        guard let imageURL = URL(string: imageURL + movie.poster_path) else { fatalError("Sorry, error") }
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
