//
//  DetailsMoviePresenter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation

final class DetailsMoviePresenter: DetailsMoviePresenterProtocols, DetailsMovieInteractorInputAndOutputProtocols {
    var arrFavoriteMovies: [Int]?
    var idMovie: Int?
    var movie: Movie?
    var presenter: DetailsMoviePresenterProtocols?
    var view: DetailsMovieViewProtocols?
    var router: DetailsMovieRouterProtocols?
    var interactor: DetailsMovieInteractorInputAndOutputProtocols?
    
    func setUpPresentToInteractor() {
        interactor?.setUpPresentToInteractor()
    }
    
    func setupInteractorToPresent(with movie: Movie, and isFavorite: String) {
        presenter?.setUpPresenterToView(with: movie, isFavorite: isFavorite)
    }
    
    func setUpPresenterToView(with movie: Movie, isFavorite: String) {
        view?.setupView(with: movie, isFavorite: isFavorite)
    }
    
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate) {
        interactor?.likeButtonTapped(isLike: isLike, delegado: delegado)
    }
    
    func changeIconLike(with image: String) {
        view?.likeIconChange(with: image)
    }
    
    func setUpRecommendationMoviesToView(with arrMovies: [Movie]) {
        view?.setUpRecommendationMovies(with: arrMovies)
    }
    
    func setUpSimilarMoviewToView(with arrMovies: [Movie]) {
        view?.setUpSimilarMoview(with: arrMovies)
    }
    
    func setUpCreditToView(with arrActors: [Credit]) {
        view?.setUpCreditsMovie(with: arrActors)
    }
    
}
