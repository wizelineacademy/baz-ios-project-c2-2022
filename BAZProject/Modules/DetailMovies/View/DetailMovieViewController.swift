//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by 1017143 on 21/10/22.
//

import UIKit
// swiftlint:disable class_delegate_protocol
protocol MovieDetailDelegate: NSObject {
    func showMovieBySection(section: MovieSections, movies: [Movie])
}

final class DetailMovieViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel!
    @IBOutlet weak var similarLbl: UILabel!
    @IBOutlet weak var recommendedLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var recomendedMovies: UICollectionView!
    @IBOutlet weak var similarMovies: UICollectionView!
    // MARK: - Properties of class
    let movieDetailPresenter = DetailPresenter(movieApiService: MovieAPI())
    var movie: Movie?
    var urlImg: String?
    var similarMovie: [Movie] =  []
    var recomendedMovie: [Movie] =  []
    // MARK: - Properties of collectionMovieMenu configuration
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant: CGFloat = 20
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow: Float = 2.3
    // MARK: - Start
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovie()
        registerCollectionSimilar()
        registerCollectionRecomended()
        movieDetailPresenter.setDetailDelegate(movieDetailDelegate: self)
        movieDetailPresenter.getRecommendedMovie(idMovie: movie?.id ?? 0)
        movieDetailPresenter.getSimilarMovie(idMovie: movie?.id ?? 0)
    }
    /// Set the values to show the movie Detail
    func setMovie() {
        self.title = movie?.title
        self.mainImage.loadImage(urlStr: urlImg ?? "")
        self.nameMovieLbl.text = movie?.title
        self.descriptionLbl.text = movie?.overview
    }
    /// Register the custom cell to show recomended movies in recomendedMovies collection
    func registerCollectionRecomended() {
        recomendedMovies.register(UINib(nibName: "MovieCollectionViewCell",
                                        bundle: Bundle(for: MovieCollectionViewCell.self)),
                                  forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    /// Register the custom cell to show recomended movies in similarMovies collection
    func registerCollectionSimilar() {
        similarMovies.register(UINib(nibName: "MovieCollectionViewCell",
                                     bundle: Bundle(for: MovieCollectionViewCell.self)),
                               forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    /// Recives a collection as parameter and return an Int with the number of elements
    ///
    ///  - Parameter nameCollection: Is a identifier of collection
    func getMoviesForCollection(nameCollection: UICollectionView) -> Int {
        switch nameCollection {
        case recomendedMovies:
            return recomendedMovie.count
        case similarMovies:
            return similarMovie.count
        default:
            return 0
        }
    }
    /// Recives a collection as parameter and return an item of enum MovieSections
    ///
    ///  - Parameter nameCollection: Is a identifier of collection
    func getCollectionType(nameCollection: UICollectionView) -> MovieSections {
        switch nameCollection {
        case recomendedMovies:
            return .recommended
        case similarMovies:
            return .similar
        default:
            return .similar
        }
    }
}

// MARK: - Implement MovieDetailDelegate
extension DetailMovieViewController: MovieDetailDelegate {
    func showMovieBySection(section: MovieSections, movies: [Movie]) {
        DispatchQueue.main.async { [self] in
            switch section {
            case .similar:
                if movies.count > 0 {
                    similarMovie = movies
                    similarMovies.reloadData()
                } else {
                    similarLbl.isHidden = true
                    similarMovies.isHidden = true
                }
            case .recommended:
                if movies.count > 0 {
                    recomendedMovie = movies
                    recomendedMovies.reloadData()
                } else {
                    recomendedMovies.isHidden = true
                    recommendedLbl.isHidden = true
                }
            }
        }
    }
}
