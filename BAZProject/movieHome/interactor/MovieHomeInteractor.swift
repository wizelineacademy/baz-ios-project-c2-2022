//
//  MovieHomeInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit
final class MovieHomeInteractor: MovieHomePresenterToInteractorProtocol,  MovieHomeDataExternalToInteractorProtocol,MovieAPIConstantsProtocol {
    
    var movieAPI: MovieAPIProtocol?
    var presenter: MovieHomeInteractorToPresenterProtocol?
    private lazy var setCategoriesUrl: [Categories : String] = [Categories.trending:TRENDINGURL, Categories.nowplaying:NOWPLAYING, Categories.popular:POPULAR, Categories.toprated:TOPRATED, Categories.upcoming:UPCOMING]
    /// This function receive parameter page
    /// - parameters
    ///      - page:  get parameter page of listMovies
    func callAPIMovie(_ page: Int) {
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: TRENDINGURL.setUrlMoviePage(page), Categories.trending.rawValue)
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: POPULAR.setUrlMoviePage(page), Categories.popular.rawValue)
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: NOWPLAYING.setUrlMoviePage(page), Categories.nowplaying.rawValue)
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: TOPRATED.setUrlMoviePage(page), Categories.toprated.rawValue)
        let _ : Movie? = movieAPI?.setMovies(urlCategoria: UPCOMING.setUrlMoviePage(page), Categories.upcoming.rawValue)
    }
    
    /// This  function receive how parameter a list of object movie
    /// - parameters
    ///     - dataMovie: get the list of movies
    ///     - enumValue: get the category of the movie
    func responseListMovies<T: Codable>(dataMovie: Result<T>, _ enumValue: String) {
        presenter?.resultApiMovies(movies: dataMovie.results, enumValue)
    }
}
