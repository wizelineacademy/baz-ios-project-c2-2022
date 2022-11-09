//
//  SearchCollectionViewCell.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 07/11/22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageField: UIImageView!
    
    static let cellIdentifier: String = "searchCell"
    private let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    func printData(movie: Movie) {
        guard let imageURL = URL(string: imageURL + movie.poster_path) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageField.image = image
            }
        }
    }
}
