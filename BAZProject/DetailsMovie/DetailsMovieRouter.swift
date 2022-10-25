//
//  DetailsMovieRouter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

class DetailsMovieRouter: DetailsMovieRouterProtocols {
    
    static func createModuleDetailsMovie(details: detailsMovie) -> UIViewController {
        let navController = DetailsMovieViewController()
        
        let presenter: DetailsMoviePresenterProtocols & DetailsMovieInteractorInputAndOutputProtocols = DetailsMoviePresenter()
        let interactor: DetailsMovieInteractorInputAndOutputProtocols = DetailsMovieInteractor()
        let router: DetailsMovieRouterProtocols = DetailsMovieRouter()
        
        navController.details = details
        navController.presenter = presenter
        presenter.view = navController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navController
    }
    
    
}
