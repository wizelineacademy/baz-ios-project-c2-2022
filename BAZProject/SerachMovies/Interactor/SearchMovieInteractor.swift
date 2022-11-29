//
//  SearchMovieInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation

final class SearchMovieInteractor: SearchMovieInteractorProtocol, MovieHomeDataExternalToInteractorProtocol, MovieAPIConstantsProtocol {
    var presenter: SearchMoviePresenterOutPutProtocol?
    
    var movieAPI: MovieAPIProtocol?
    
    /// This function receive parameters
    /// - parameters
    ///      - page: get the page of list Movie
    ///      - idMovie: set id of the movie
    func callApiAll(_ page: Int, idMovie: String) {
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: SEARCH.setSearchMovieId(idMovie), Categories.trending.rawValue)
    }
    /// This function receive parameters
    /// - parameters
    ///      - dataMovie: get List Movies
    ///      - enumValue: get Category of the movie
    func responseListMovies<T>(dataMovie: Result<T>, _ enumValue: String) {
        presenter?.resultApiMovies(movies: dataMovie.results)
    }
    
    
}
