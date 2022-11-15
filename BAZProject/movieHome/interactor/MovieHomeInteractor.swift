//
//  MovieHomeInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit
final class MovieHomeInteractor: MovieHomePresenterToInteractorProtocol,  MovieHomeDataExternalToInteractorProtocol,MovieAPIConstantsProtocol{
    
    
    var movieAPI: MovieAPIProtocol?
    var presenter: MovieHomeInteractorToPresenterProtocol?
    ///This function does not receive parameters, call the service of movies
    func callMoviesApi(){
        self.movieAPI?.setMovies()
    }
    /// This  function receive how parameter a list of object movie
    /// - parameters
    ///     - movieList get the list of movies
    func responseListMovies(moviesList: [Movie]) {
        presenter?.resultMoviesList(movies: moviesList)
    }
}
