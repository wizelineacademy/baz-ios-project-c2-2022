//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

final class SearchMoviePresenter : SearchMoviePresenterProtocol, SearchMoviePresenterOutPutProtocol {
    var interactor: SearchMovieInteractorProtocol?
    
    var router: SearchMovieRouterProtocol?
    
    var view: SearchMovieViewProtocol?
    
    var setResultMovies: [Movie] = []
    
    /// This function receive parameters
    /// - parameters
    ///      - page: get the page of list Movie
    ///      - idMovie: set id of the movie
    func callSearchMovies(_ page: Int, idMovie: String) {
        interactor?.callApiAll(page, idMovie: idMovie)
    }
    
    /// This function receive parameters
    /// - parameters
    ///      - movies: parameter generics type Models
    func resultApiMovies<T>(movies: [T]) {
        guard let listMovies = movies as? [Movie] else { return }
        self.setResultMovies = listMovies
        view?.reloadTableView()
    }
    
    /// This function receive parameters
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    ///      - navigation: get viewController position
    func didSelectMovie(at indexPath: IndexPath, listMovies: [Movie], from navigation: UIViewController) {
        router?.navigationDetailMovie(at: indexPath, listMovies: listMovies, from: navigation)
    }
}
