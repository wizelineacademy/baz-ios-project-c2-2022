//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by 1028092 on 08/11/22.
//

import Foundation
import UIKit
class MovieDetailViewController: UIViewController, MovieDetailDataViewControllerProtoco {
    
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var subtitleMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setDataMovie(movieData: Movie) {
        imagePoster?.loadFromNetwork(movieData.poster)
        titleMovie?.text = movieData.title
        subtitleMovie?.text = movieData.backdrop
        descriptionMovie?.text = movieData.overview
        
    }
}
