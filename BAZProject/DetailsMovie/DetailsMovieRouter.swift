//
//  DetailsMovieRouter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

final class DetailsMovieRouter: DetailsMovieRouterProtocols {
    
    static func createModuleDetailsMovie(movie: Movie) -> UIViewController {
        let navController = DetailsMovieViewController(movie: movie)
        
        let presenter: DetailsMoviePresenterProtocols & DetailsMovieInteractorInputAndOutputProtocols = DetailsMoviePresenter()
        let interactor: DetailsMovieInteractorInputAndOutputProtocols = DetailsMovieInteractor()
        let router: DetailsMovieRouterProtocols = DetailsMovieRouter()
        
        navController.presenter = presenter
        presenter.view = navController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navController
    }
    
    
}