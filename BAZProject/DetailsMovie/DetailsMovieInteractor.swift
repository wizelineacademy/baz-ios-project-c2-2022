//
//  DetailsMovieInteractor.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation

final class DetailsMovieInteractor: DetailsMovieInteractorInputAndOutputProtocols {
    var arrFavoriteMovies: [Int]?
    var view: DetailsMovieViewProtocols?
    var idMovie: Int?
    var movie: Movie?
    var presenter: DetailsMoviePresenterProtocols?
    
    /// setUpPresentToInteractor: config data to present to user
    ///  - Parameter movie: object type Movie
    func setUpPresentToInteractor() {
        getArrRecommendationMovies()
        getArrSimilarMovies()
        getArrCrredits()
        guard let movie = movie else {
            return
        }
        let isFavorite = arrFavoriteMovies?.contains(movie.id) ?? false
        let strIcon = isFavorite ? "heart.fill" : "heart"
        setupInteractorToPresent(with: movie, and: strIcon)
    }
    
    /// setupInteractorToPresent: send object Movie model
    ///  - Parameter movie: object type DetailsMovieModel
    ///  - Parameter isFavorite: name icon to show
    func setupInteractorToPresent(with movie: Movie, and isFavorite: String) {
        presenter?.setUpPresenterToView(with: movie, isFavorite: isFavorite)
    }
    
    /// likeButtonTapped: determ icon like into view
    ///  - Parameter isLiked: bool that determ is like o not the movie
    ///  - Parameter delegado: DetailMovieDelegate to add or remove into array favorite id´s 
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate) {
        guard let id = idMovie else { return }
        if isLike {
            delegado.addMovie(with: id)
        } else {
            delegado.removeMovie(with: id)
        }
        let imagePath = isLike ? "heart.fill" : "heart"
        presenter?.changeIconLike(with: imagePath )
    }
    
    /// getArrRecommendationMovies: request recommendation movies with movie id and send it to present
    func getArrRecommendationMovies() {
        guard let id = movie?.id else { return }
        RecommendationAPI().searchRecommendationMovies(with: "\(id)", completion: { result in
            switch result {
            case .success(let res):
                self.presenter?.setUpRecommendationMoviesToView(with: res.movies)
            case .failure(let error):
                debugPrint(error)
                self.presenter?.setUpRecommendationMoviesToView(with: [])
            }
        })
    }
    
    
    /// getArrSimilarMovies: request similar movies with movie id  and send it to presenter
    func getArrSimilarMovies() {
        guard let id = movie?.id else { return }
        SimilarAPI().searchSimilarMovies(with: "\(id)", completion: { result in
            switch result {
            case .success(let res):
                self.presenter?.setUpSimilarMoviewToView(with: res.movies)
            case .failure(let error):
                debugPrint(error)
                self.presenter?.setUpSimilarMoviewToView(with: [])
            }
        })
    }
    
    /// getArrCrredits: request to API info about movie credits
    func getArrCrredits() {
        guard let id = movie?.id else { return }
        CreditAPI().getCredits(with: "\(id)", completion: { result in
            switch result {
            case .success(let res):
                self.presenter?.setUpCreditToView(with: res.actors)
            case .failure(_):
                self.presenter?.setUpCreditToView(with: [])
            }
        })
    }
}
