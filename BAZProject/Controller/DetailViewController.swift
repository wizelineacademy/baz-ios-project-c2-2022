//
//  DetailViewController.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 03/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        if let movie = movie {
            textField.text = movie.overview
            getImage(pathUrl: movie.poster_path)
        }
    }
    
    func getImage(pathUrl: String) {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + pathUrl) else { fatalError("Sorry, error") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async { [weak self] in
                self?.imageField.image = image
            }
        }
    }
}
