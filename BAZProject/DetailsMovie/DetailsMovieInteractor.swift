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
    
    func setUpPresentToInteractor(with movie: Movie) {
        let detailMovie = movie.adaptToDetailsMovieModelAdapter(with: arrFavoriteMovies ?? [])
        idMovie = movie.id
        setupInteractorToPresent(with: detailMovie)
    }
    
    func setupInteractorToPresent(with movie: DetailsMovieModel) {
        presenter?.setUpPresenterToView(with: movie)
    }
    
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
