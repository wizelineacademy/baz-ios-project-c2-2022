//
//  MainTableViewCell.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 03/11/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    func printData(movie: Movie) {
        titleLabel.text = movie.title
        //imageField.image = movie
        //getImage(show: show)
    }
    
//    func getImage(show: Show) {
//        guard let imageURL = URL(string: show.image.medium) else { fatalError("Sorry, error") }
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async { [weak self] in
//                self?.imageField.image = image
//                self?.setNeedsLayout()
//            }
//        }
//    }
}
