//
//  DetailsMoviePresenter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

final class DetailsMoviePresenter: DetailsMoviePresenterProtocols, DetailsMovieInteractorInputAndOutputProtocols {
    var arrFavoriteMovies: [Int]?
    var presenter: DetailsMoviePresenterProtocols?
    var view: DetailsMovieViewProtocols?
    var router: DetailsMovieRouterProtocols?
    var interactor: DetailsMovieInteractorInputAndOutputProtocols?
    
    func setUpPresentToInteractor(with movie: Movie) {
        interactor?.setUpPresentToInteractor(with: movie)
    }
    
    func setupInteractorToPresent(with movie: DetailsMovieModel) {
        presenter?.setUpPresenterToView(with: movie)
    }
    
    func setUpPresenterToView(with movie: DetailsMovieModel) {
        view?.setupView(with: movie)
    }
    
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate) {
        interactor?.likeButtonTapped(isLike: isLike, delegado: delegado)
    }
    
    func changeIconLike(image: UIImage) {
        view?.likeIconChange(image: image)
    }
}
