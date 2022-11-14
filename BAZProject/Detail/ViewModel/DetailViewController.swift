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
    @IBOutlet weak var collectionSimilar: UICollectionView!
    @IBOutlet weak var collectionRecommended: UICollectionView!
    
    // MARK: - Properties
    var dataMovie: Movie?
    private var movieAPI = MovieAPI()
    let identifier = "DetailCell"
    var idMovie: Int {
        return self.dataMovie?.id ?? 0
    }
    
    var arraySimilar: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionSimilar.reloadData()
            }
        }
    }
    var arrayRecommended: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionRecommended.reloadData()
            }
        }
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateDetailView()
        registerCollectionRecomended()
        registerCollectionSimilar()
        getMoviesSimilar()
        getMoviesRecommended()
    }
    
    //MARK: - Actions
    @IBAction func closeActionClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /// Register the custom cell to show recomended movies in collectionRecomend
    func registerCollectionRecomended() {
        collectionRecommended.register(UINib(nibName: identifier,
                                             bundle: Bundle(for: DetailCell.self)),
                                       forCellWithReuseIdentifier: identifier)
    }
    /// Register the custom cell to show recomended movies in collectionSimilar
    func registerCollectionSimilar() {
        collectionSimilar.register(UINib(nibName: identifier,
                                         bundle: Bundle(for: DetailCell.self)),
                                   forCellWithReuseIdentifier: identifier)
    }
    /// Setting of the detail of the movies
    private func configurateDetailView() {
        lblTitle.text = dataMovie?.title
        txtReseña.text = dataMovie?.overview
        if let dataMovie = dataMovie {
            let imageMovie = UIImage(data: movieAPI.getImage(urlImage: dataMovie.posterPath)) ?? UIImage(named: "poster")
            imvPoster.image = imageMovie
        }
    }
    /// Makes a query to the service
    private func getMoviesSimilar() {
        movieAPI.getMovieSection(section: MoreMovies.similar.rawValue, idMovie: idMovie, completion: { result in
            if let moviesSimilar = result {
                self.arraySimilar = moviesSimilar
            }
        })
    }
    /// Makes a query to the service
    private func getMoviesRecommended() {
        movieAPI.getMovieSection(section: MoreMovies.recommended.rawValue, idMovie: idMovie, completion: { result in
            if let moviesRecommended = result {
                self.arrayRecommended = moviesRecommended
            }
        })
    }
}

// MARK: - CollectionView Delegate
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionSimilar:
            return arraySimilar.count
        case collectionRecommended:
            return arrayRecommended.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DetailCell else {
            return UICollectionViewCell()
        }
        switch collectionView {
        case collectionSimilar:
            cell.showDetailsMovies(movie: arraySimilar[indexPath.row])
        case collectionRecommended:
            cell.showDetailsMovies(movie: arrayRecommended[indexPath.row])
        default:
            cell.showDetailsMovies(movie: arraySimilar[indexPath.row])
        }
        return cell
        
    }
}
