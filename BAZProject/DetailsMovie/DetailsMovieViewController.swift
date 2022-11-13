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
    @IBOutlet weak var recommendationCollection: UICollectionView!
    @IBOutlet weak var similarCollection: UICollectionView!
    
    var presenter: DetailsMoviePresenterProtocols?
    let delegate: DetailsMovieDelegate
    var likedMovie: Bool
    
    init(delegado: DetailsMovieDelegate) {
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
        presenter?.setUpPresentToInteractor()
        NotificationCenter.default.post(name: .countMovieDetails, object: nil)
    }
    
    /// setUpImageMovie: config background movie image
    ///  - Parameter moviePath: name background path movie
    private func setUpImageMovie(with moviePath: String) {
        ImageAPI.getImage(with: moviePath) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imagenMovie):
                    self.backgroundImage.image = imagenMovie
                case .failure(_):
                    self.backgroundImage.image = UIImage()
                }
            }
        }
    }

    /// clickLikedMovie: Func  execute when user click into like button
    @IBAction func clickLikedMovie() {
        likedMovie = !likedMovie
        presenter?.likeButtonTapped(isLike: likedMovie, delegado: delegate)
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    /// setupView: config view with info
    ///  - Parameter movie: object with info to show
    func setupView(with movie: Movie, isFavorite: String) {
        self.titleLbl.text = movie.title
        self.descriptionLbl.text = movie.overview
        self.btnLikedMovie.setImage(UIImage(systemName: isFavorite), for: .normal)
        setUpImageMovie(with: movie.backdropPath ?? "poster")
        self.recommendationCollection.reloadData()
        
    }
    /// likeIconChange: func change heart icon tapped button like
    ///  - Parameter imagePath: name background path movie
    func likeIconChange(with imagePath: String) {
        DispatchQueue.main.async {
            self.btnLikedMovie.setImage(UIImage(systemName: imagePath), for: .normal)
        }
    }
}
