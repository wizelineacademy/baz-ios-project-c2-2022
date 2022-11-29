//
//  MovieHomePresenter.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

final class MovieHomePresenter: MoviewHomeViewToPresenterProtocol, MovieHomeInteractorToPresenterProtocol {
    
    var listMovies: [String:[Movie]] = [:]
    
    var setMoviesCategories: [String] = Categories.allCases.map{ $0.rawValue }
    
    var interactor: MovieHomePresenterToInteractorProtocol?
    
    var router: MovieHomePresenterToRouterProtocol?
    
    var view: MovieHomePresenterToViewProtocol?
    /// This function does not parameters, this call the service API of movies
    func callServiceApis(_ page: Int) {
        interactor?.callAPIMovie(page)
    }
    /// This function receive a parameter is a list object called movie
    ///  - parameters
    ///     - movies is a variable list of type object
    ///     - enumValues: set category of type String
    func resultApiMovies<T : Codable>(movies: [T],_ enumValues: String) {
        guard let moviesList = movies as? [Movie] else { return }
        DispatchQueue.main.async {
            self.listMovies[enumValues] = moviesList
            self.view?.reloadMoviesTableView()
        }
    }
    /// This function receive parameter viewController
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    func navigationToDetailMovie(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController) {
        router?.navigationToMovieDetail(at: indexPath, listMovies: listMovies, from: navigation)
    }
}
