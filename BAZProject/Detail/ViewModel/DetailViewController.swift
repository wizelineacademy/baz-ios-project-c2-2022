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
    
    // MARK: - Properties
    var dataMovie: Movie?
    private var movieAPI = MovieAPI()
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDetailView()
    }
    /// Setting of the detail of the movies for the cells
    private func configurateDetailView() {
        lblTitle.text = dataMovie?.title
        txtReseña.text = dataMovie?.overview
        if let dataMovie = dataMovie {
            let imageMovie = UIImage(data: movieAPI.getImage(urlImage: dataMovie.posterPath)) ?? UIImage(named: "poster")
            imvPoster.image = imageMovie
        }
    }
}
