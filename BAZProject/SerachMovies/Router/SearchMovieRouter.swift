//
//  SearchMovieRouter.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

final class SearchMovieRouter : SearchMovieRouterProtocol {
    
    /// This function receive parameter viewController
    /// - parameters
    ///      - not receive parameters
    static func moduleInitSearch() -> UIViewController {
        
        let viewController: SearchMovieViewProtocol? = SearchMovieViewController()
        let presenter: SearchMoviePresenterProtocol & SearchMoviePresenterOutPutProtocol = SearchMoviePresenter()
        var interactor: SearchMovieInteractorProtocol & MovieHomeDataExternalToInteractorProtocol & MovieAPIConstantsProtocol = SearchMovieInteractor()
        let router: SearchMovieRouterProtocol = SearchMovieRouter()
        
        var movieAPI: MovieAPIProtocol = MovieAPI()
        
        
        viewController?.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.movieAPI = movieAPI
        movieAPI.interactor = interactor
        guard let view: UIViewController = viewController as?  UIViewController else { return UIViewController()}
        
        return view
    }
    /// This function receive parameter viewController
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    func navigationDetailMovie(at indexPath: IndexPath, listMovies: [Movie], from navigation: UIViewController) {
        MovieDetailRouter.createModuleDetailView(at: indexPath, listMovies: listMovies, from: navigation)
    }
}
