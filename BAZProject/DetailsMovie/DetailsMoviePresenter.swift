//
//  DetailsMoviePresenter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation

final class DetailsMoviePresenter: DetailsMoviePresenterProtocols, DetailsMovieInteractorInputAndOutputProtocols {
    var presenter: DetailsMoviePresenterProtocols?
    var view: DetailsMovieViewProtocols?
    var router: DetailsMovieRouterProtocols?
    var interactor: DetailsMovieInteractorInputAndOutputProtocols?
    
    func setUpPresentToInteractor() {
        interactor?.setUpPresentToInteractor()
    }
    
    func btnLikedClick() {
        interactor?.btnLikedClick()
    }
}
