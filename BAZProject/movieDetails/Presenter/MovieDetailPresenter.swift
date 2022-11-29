//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by 1028092 on 20/11/22.
//

import Foundation
import UIKit
final class MovieDetailPresenter: MovieDetailPresenterInputProtocol, MovieDetailPresenterProtocol {
    var listMovies: [String : [Any]] = [:]
    
    var setMoviesRecommendations: [String] = Recommendations.allCases.map{ $0.rawValue }
    
    var view: MovieDetailViewProtocol?
    
    var interactor: MovieDetailInteractorProtocol?
    
    var router: MovieDetailRouterProtocol?
    
    private var counted: Int = 0
    /// This function does not parameters, this call the service API of movies
    func callServiceApis(_ page: Int,idMovie: String) {
        interactor?.callApiAll(page,idMovie: idMovie)
    }
    
    /// This function receive a parameter is a list object called movie
    ///  - parameters
    ///     - list is a variable list of type object
    ///     - enumValues: set category of type String
    func resultApiMovies<T>(list: [T], _ enumValues: String) {
        DispatchQueue.main.async {
            self.listMovies[enumValues] = list
            if list.count <= 0 {
                guard let setIndex = self.setMoviesRecommendations.firstIndex(of: enumValues) else { return }
                self.setMoviesRecommendations.remove(at: setIndex)
            }
            self.view?.reloadReviewsDetail()
        }
    }
    /// This function receive parameter navigationToDetailMovie
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    func navigationToDetailMovie(at indexPath: IndexPath, listMovies: [Movie], from navigation: UIViewController) {
        MovieDetailRouter.createModuleDetailView(at: indexPath, listMovies: listMovies, from: navigation)
    }
    /// This function receive a parameter is a list object called movie
    ///  - parameters
    ///     - section is position current list Movies
    func generateListMovie(section: Int) -> [Any] {
        let getListMovies = self.setMoviesRecommendations[section]
        guard let movies = self.listMovies.first(where: { $0.key == getListMovies}) else{ return [] }
        return movies.value
    }
}
