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
        guard let movie = movie else {
            return
        }
        let isFavorite = arrFavoriteMovies?.contains(movie.id) ?? false
        let strIcon = isFavorite ? "heart.fill" : "heart"
        setupInteractorToPresent(with: movie, and: strIcon)
    }
    
    /// setupInteractorToPresent: send object Movie model
    ///  - Parameter movie: object type DetailsMovieModel
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
}
