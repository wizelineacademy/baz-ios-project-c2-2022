//
//  MovieHomePresenter.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit
final class MovieHomePresenter: MoviewHomeViewToPresenterProtocol, MovieHomeInteractorToPresenterProtocol {
    
    
    var interactor: MovieHomePresenterToInteractorProtocol?
    
    var router: MovieHomePresenterToRouterProtocol?
    
    var view: MovieHomePresenterToViewProtocol?
    /// This function does not parameters, this call the service API of movies
    func callApiMoviesHomeData() {
        interactor?.callMoviesApi()
    }
    /// This function receive a parameter is a list object called movie
    ///  - parameters
    ///     - movies is a variable list of type object
    func resultMoviesList(movies: [Movie]) {
        self.view?.callApiListMovies(listMovies: movies)
    }
}
