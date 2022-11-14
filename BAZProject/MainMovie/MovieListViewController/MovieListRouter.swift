//
//  MovieListRouter.swift
//  BAZProject
//
//  Created by 1030364 on 26/10/22.
//

import UIKit

final class MovieListRouterFactory {
    func make(endPoint: PaginatedEndPoint) -> UIViewController {
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        guard let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            fatalError()
        }
        let interactor = MainMovieInteractorImp(endPoint: endPoint)
        let router = MainMovieRouter()
        let presenter = MovieListPresenterImp(interactor: interactor, router: router)

        movieViewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = movieViewController
        movieViewController.endPoint = endPoint
        return movieViewController
    }
}

final class MovieListRouter: MainMovieWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(endPoint: PaginatedEndPoint) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        return MovieListRouterFactory().make(endPoint: endPoint)
    }
}
