//
//  MovieHomeRouter.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit
final class MovieHomeRouter: MovieHomePresenterToRouterProtocol{
    /// This function receive parameter viewController
    /// - parameters
    ///      - view: receive the view of viewController called
    static func createModule() -> UIViewController {
        let view = TrendingViewController.init()
        var presenter: MoviewHomeViewToPresenterProtocol & MovieHomeInteractorToPresenterProtocol = MovieHomePresenter()
        var interactor: MovieHomePresenterToInteractorProtocol & MovieHomeDataExternalToInteractorProtocol = MovieHomeInteractor()
        let router: MovieHomePresenterToRouterProtocol = MovieHomeRouter()
        var movieAPI: MovieAPIProtocol = MovieAPI()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.movieAPI = movieAPI
        movieAPI.interactor = interactor
        
        return view
    }
    /// This function receive parameter viewController
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    func navigationToMovieDetail(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController) {
        MovieDetailRouter.createModuleDetailView(at: indexPath, listMovies: listMovies, from: navigation)
    }
}
