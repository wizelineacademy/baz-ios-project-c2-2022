//
//  DetailsMovieInteractor.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

final class DetailsMovieInteractor: DetailsMovieInteractorInputAndOutputProtocols {
    var arrFavoriteMovies: [Int]?
    var view: DetailsMovieViewProtocols?
    var idMovie: Int = 0
    var presenter: DetailsMoviePresenterProtocols?
    
    /// setUpPresentToInteractor: config data to present to user
    ///  - Parameter movie: object type Movie
    func setUpPresentToInteractor(with movie: Movie) {
        let detailMovie = movie.adaptToDetailsMovieModelAdapter(with: arrFavoriteMovies ?? [])
        idMovie = movie.id
        setupInteractorToPresent(with: detailMovie)
    }
    
    /// setupInteractorToPresent: send object Movie model
    ///  - Parameter movie: object type DetailsMovieModel
    func setupInteractorToPresent(with movie: DetailsMovieModel) {
        presenter?.setUpPresenterToView(with: movie)
    }
    
    /// likeButtonTapped: determ icon like into view
    ///  - Parameter isLiked: bool that determ is like o not the movie
    ///  - Parameter delegado: DetailMovieDelegate to add or remove into array favorite id´s 
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate) {
        if isLike {
            delegado.addMovie(with: idMovie)
        } else {
            delegado.removeMovie(with: idMovie)
        }
        let imageLiked = isLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        presenter?.changeIconLike(image: imageLiked ?? UIImage())
    }
}
