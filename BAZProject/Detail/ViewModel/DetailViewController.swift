//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 03/11/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtReseña: UITextView!
    @IBOutlet weak var imvPoster: UIImageView!
    
    var dataMovie: Movie?
    private var movieAPI = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDetailView()
    }
    
    private func configurateDetailView() {
        lblTitle.text = dataMovie?.title
        txtReseña.text = dataMovie?.overview
        if let dataMovie = dataMovie {
            let imageMovie = UIImage(data: movieAPI.getImage(urlImage: dataMovie.poster_path)) ?? UIImage(named: "poster")
            imvPoster.image = imageMovie
        }
    }
}
