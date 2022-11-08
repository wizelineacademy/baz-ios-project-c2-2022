//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 01/11/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var imgDetailMovie: UIImageView!
    @IBOutlet weak var txvDetailOverView: UITextView!
    @IBOutlet weak var lblDetailTitle: UILabel!
    @IBOutlet weak var collectionSimilar: UICollectionView!
    @IBOutlet weak var collectionRecommended: UICollectionView!
    
    //MARK: Properties
    let movieAPI = MovieAPI()
    var arraySimilar: [InfoMovies] = [] {
        didSet {
        DispatchQueue.main.async {
            self.collectionSimilar.reloadData()
        }
    }
}
    var arrayRecommended: [InfoMovies] = [] {
        didSet {
        DispatchQueue.main.async {
            self.collectionRecommended.reloadData()
        }
    }
}
    var movie: InfoMovies!
    var idMovie: Int {
        return self.movie.id!
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        movieDetailSetUp()
        getMoviesSimilar()
        getMoviesRecommended()
    }
  
    //MARK: private methods
    private func instanceFromNib() {
        collectionSimilar.register(UINib(nibName: "MoreMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoreMoviesCollectionViewCell")
        collectionRecommended.register(UINib(nibName: "MoreMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoreMoviesCollectionViewCell")
    }
    
    
    private func movieDetailSetUp() {
        if let title = movie?.title, let posterPath = movie?.posterPath, let overview = movie?.overview {
            lblDetailTitle.text = title
            txvDetailOverView.text = overview
            imgDetailMovie.setMovieImage(nameImage: posterPath)
        }
    }
    
    private func getMoviesSimilar() {
        self.movieAPI.getMoreMovies(section: MoreMovies.similar.rawValue, idMovie: idMovie, completion: { result in
            switch result {
            case .success(let moviesSimilar):
                self.arraySimilar = moviesSimilar
            case .failure(let error):
                debugPrint("Error\(error)")
                self.basicAlert(title: "Hubo algún problema", message: "\(error)")
            }
        })
    }
    
    private func getMoviesRecommended() {
        self.movieAPI.getMoreMovies(section: MoreMovies.recommended.rawValue, idMovie: idMovie, completion: { result in
            switch result {
            case .success(let moviesRecommended):
                self.arrayRecommended = moviesRecommended
            case .failure(let error):
                debugPrint("Error\(error)")
                self.basicAlert(title: "Hubo algún problema", message: "\(error)")
            }
        })
    }
}

// MARK: - collectionView's DataSource

extension DetailMovieViewController: UICollectionViewDataSource {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreMoviesCollectionViewCell", for: indexPath) as? MoreMoviesCollectionViewCell else {
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
