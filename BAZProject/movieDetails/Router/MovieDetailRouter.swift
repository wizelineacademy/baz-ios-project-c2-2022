//
//  MovieDetailRouter.swift
//  BAZProject
//
//  Created by 1028092 on 20/11/22.
//

import Foundation
import UIKit
final class MovieDetailRouter: MovieDetailRouterProtocol {
    
    /// This function receive parameter createModuleDetailView
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    static public func createModuleDetailView(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController) {
        let viewController: MovieDetailViewProtocol? = MovieDetailViewController(movieDetailData: listMovies[indexPath.row])
        let presenter: MovieDetailPresenterInputProtocol & MovieDetailPresenterProtocol = MovieDetailPresenter()
        var interactor: MovieDetailInteractorProtocol & MovieHomeDataExternalToInteractorProtocol & MovieAPIConstantsProtocol = MovieDetailInteractor()
        let router: MovieDetailRouterProtocol = MovieDetailRouter()
        var movieAPI: MovieAPIProtocol = MovieAPI()
        
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.movieAPI = movieAPI
        movieAPI.interactor = interactor
        viewController?.presenter = presenter
        presenter.view = viewController
        guard let view: UIViewController = viewController as? UIViewController else { return }
        navigation.navigationController?.pushViewController(view, animated: true)
    }
    /// This function receive parameter navigationDetailMovieView
    /// - parameters
    ///      - movie: get model Movie
    ///      - navigation: navigation other controller
    func navigationDetailMovieView(movie: Movie, from navigation: UIViewController) {
        let viewDetail = MovieDetailViewController(movieDetailData: movie)
        navigation.navigationController?.pushViewController(viewDetail, animated: true)
    }
}
