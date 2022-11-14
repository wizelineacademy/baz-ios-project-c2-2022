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
    @IBOutlet weak var labelRecommendation: UILabel!
    @IBOutlet weak var labelSimilar: UILabel!
    
    var presenter: DetailsMoviePresenterProtocols?
    let delegate: DetailsMovieDelegate
    var likedMovie: Bool
    var similarMovies: [Movie] = []
    var recommendationMovies: [Movie] = []
    
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
        setUpView()
        presenter?.setUpPresentToInteractor()
        NotificationCenter.default.post(name: .countMovieDetails, object: nil)
    }
    
    /// setUpView: config to view with collection views
    private func setUpView(){
        self.recommendationCollection.dataSource = self
        self.recommendationCollection.delegate = self
        self.recommendationCollection.register(UINib(nibName: MoviesCategoryCollectionViewCell.nameCell, bundle: nil), forCellWithReuseIdentifier: MoviesCategoryCollectionViewCell.identifier)
        self.similarCollection.dataSource = self
        self.similarCollection.delegate = self
        self.similarCollection.register(UINib(nibName: MoviesCategoryCollectionViewCell.nameCell, bundle: nil), forCellWithReuseIdentifier: MoviesCategoryCollectionViewCell.identifier)
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
    }
    /// likeIconChange: func change heart icon tapped button like
    ///  - Parameter imagePath: name background path movie
    func likeIconChange(with imagePath: String) {
        DispatchQueue.main.async {
            self.btnLikedMovie.setImage(UIImage(systemName: imagePath), for: .normal)
        }
    }
    /// setUpRecommendationMovies: received array recommendation movies, assigned to local array and reload collection view
    ///  - Parameter arrMovies: array recomendation movies
    func setUpRecommendationMovies(with arrMovies: [Movie]) {
        self.recommendationMovies = arrMovies
        DispatchQueue.main.async {
            self.recommendationCollection.isHidden = arrMovies.isEmpty
            self.labelRecommendation.isHidden = true
            self.recommendationCollection.reloadData()
        }
    }
    
    /// setUpSimilarMoview: received array similar movies, assigned to local array and reload collection view
    ///  - Parameter arrMovies: array simiarl movies
    func setUpSimilarMoview(with arrMovies: [Movie]) {
        self.similarMovies = arrMovies
        DispatchQueue.main.async {
            self.similarCollection.isHidden = arrMovies.isEmpty
            self.labelSimilar.isHidden = arrMovies.isEmpty
            self.similarCollection.reloadData()
        }
    }
    
}

extension DetailsMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendationCollection {
            return self.recommendationMovies.count
        } else {
            return self.similarMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recommendationCollection {
            guard let cell = recommendationCollection.dequeueReusableCell(withReuseIdentifier: MoviesCategoryCollectionViewCell.identifier, for: indexPath) as? MoviesCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setUpCell(recommendationMovies[indexPath.row], [])
            return cell
        } else if collectionView == self.similarCollection {
            guard let cell = similarCollection.dequeueReusableCell(withReuseIdentifier: MoviesCategoryCollectionViewCell.identifier, for: indexPath) as? MoviesCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setUpCell(similarMovies[indexPath.row], [])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DetailsMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem: CGFloat = 120
        return CGSize(width: widthPerItem, height: widthPerItem * 1.7)
    }

}
