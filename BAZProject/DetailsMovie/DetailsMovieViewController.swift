//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import UIKit

protocol DetailsMovieDelegate {
    func returnIdMovie(_ idMovie: Int)
}

final class DetailsMovieViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnLikedMovie: UIButton!
    
    var presenter: DetailsMoviePresenterProtocols?
    var movie: Movie?
    var delegate: DetailsMovieDelegate?
    var likedMovie: Bool = false
    private let movieApi = MovieAPI()
    private let imageApi = ImageAPI()
    
    init(movie: Movie, delegado: DetailsMovieDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        self.delegate = delegado
        self.likedMovie = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        var moviesCount = UserDefaults.standard.integer(forKey: "countMovies")
        moviesCount += 1
        UserDefaults.standard.set(moviesCount, forKey: "countMovies")
        NotificationCenter.default.post(name: .countMovieDetails, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let info = movie else {
            self.dismiss(animated: true)
            return
        }
        let posterPath = info.backdropPath ?? "poster"
        imageApi.getImage(with: posterPath) { result in
            switch result {
            case .success(let image):
                self.backgroundImage.image = image
            case .failure(_):
                self.backgroundImage.image = UIImage(named: "poster")
            }
        }
        self.titleLbl.text = info.title
        self.descriptionLbl.text = info.overview
        let imageLiked = likedMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.btnLikedMovie.setImage(imageLiked, for: .normal)
    }
    
    @IBAction func clickLikedMovie() {
        likedMovie = !likedMovie
        let imageLiked = likedMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.btnLikedMovie.setImage(imageLiked, for: .normal)
        delegate?.returnIdMovie(movie?.id ?? -1)
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    
}
