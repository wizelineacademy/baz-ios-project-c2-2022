//
//  MovieListRouter.swift
//  BAZProject
//
//  Created by 1030364 on 26/10/22.
//

import UIKit

class MovieListRouter: MainMovieWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(endPoint: EndPoint) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        guard let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            fatalError()
        }
        let interactor = MainMovieInteractor()
        let router = MovieListRouter()
        let presenter = MainMoviePresenter(interface: movieViewController, interactor: interactor, router: router)

        movieViewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = movieViewController
        movieViewController.endPoint = endPoint
        return movieViewController
    }
}
