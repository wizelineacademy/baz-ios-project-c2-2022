//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import UIKit

protocol DetailsMovieDelegate {
    func addMovie(with id: Int)
    func removeMovie(with id: Int)
}

final class DetailsMovieViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnLikedMovie: UIButton!
    
    var presenter: DetailsMoviePresenterProtocols?
    let movie: Movie
    let delegate: DetailsMovieDelegate
    var likedMovie: Bool
    
    init(movie: Movie, delegado: DetailsMovieDelegate) {
        self.movie = movie
        self.delegate = delegado
        self.likedMovie = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.moviesCount()
        presenter?.setUpPresentToInteractor(with: movie)
        NotificationCenter.default.post(name: .countMovieDetails, object: nil)
    }
    
    private func setUpImageMovie(with moviePath: String) {
        ImageAPI.getImage(with: moviePath) { result in
            switch result {
            case .success(let imagenMovie):
                self.backgroundImage.image = imagenMovie
            case .failure(_):
                self.backgroundImage.image = UIImage()
            }
        }
    }

    @IBAction func clickLikedMovie() {
        likedMovie = !likedMovie
        presenter?.likeButtonTapped(isLike: likedMovie, delegado: delegate)
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    func setupView(with movie: DetailsMovieModel) {
        self.titleLbl.text = movie.titleMovie
        self.descriptionLbl.text = movie.descriptionMovie
        self.btnLikedMovie.setImage(movie.likedMovie, for: .normal)
        setUpImageMovie(with: movie.backgroundImage)
        
    }
    
    func likeIconChange(image: UIImage) {
        self.btnLikedMovie.setImage(image, for: .normal)
    }
}
