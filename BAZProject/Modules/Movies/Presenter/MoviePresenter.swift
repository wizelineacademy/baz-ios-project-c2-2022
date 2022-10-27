//
//  MoviePresenter.swift
//  BAZProject
//
//  Created by 1017143 on 17/10/22.
//

import Foundation

class MoviePresenter {
    weak private var movieViewDelegate: MovieViewDelegate?
    private let movieApiService: MovieAPI
    private var movies: [Movie] =  []
    private var similarMovies: [Movie] =  []
    private var recomendedMovies: [Movie] =  []
    private var searchResultMovies: [Movie] =  []
    // MARK: - Init of class
    init(movieApiService: MovieAPI) {
        self.movieApiService = movieApiService
    }
    /// Get the value of the delegate
    func setMovieDelegate(movieViewDelegate: MovieViewDelegate?) {
        self.movieViewDelegate = movieViewDelegate
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    func getMoviesByCategory(category: CategoryMovieType) {
        movieApiService.getMovies(category: category.endpoint) { [weak self] movies in
            if let movies = movies {
                self?.movies = movies
                self?.movieViewDelegate?.showMovies()
            }
        }
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    ///
    ///  - Parameter wordToSearch: String to search in request
    func getMoviesSearched(wordToSearch: String) {
        movieApiService.getMoviesSearched(wordToSearch: wordToSearch) { movies in
            if let movies = movies {
                self.searchResultMovies = movies
                self.movieViewDelegate?.showResults()
            }
        }
    }
    /// Get the number of movies included in the query
    ///
    /// - Returns: The number of movies
    func getTotalMovies() -> Int {
        return self.movies.count
    }
    /// Get the number of movies included in the query
    ///
    /// - Returns: The number of movies
    func getSearchedMovies() -> Int {
        return self.searchResultMovies.count
    }
    /// Get a movie object from an array of movies
    ///
    /// - Parameters:
    ///   - indexPath: Is the index of the array to query
    ///   - type: Identifier to choose a collection
    /// - Returns: The a Movie object
    func getMovie(indexPath: Int, type: CardType) -> Movie? {
        switch type {
        case .table:
            return self.movies[indexPath]
        case .collection:
            return self.searchResultMovies[indexPath]
        }
    }
    /// Get the url of the image
    ///
    /// - Parameters:
    ///   - indexPath: Is the index of the array the url of the image
    ///   - size: Identifier to choose the image size url
    /// - Returns: A string type url
    func getUrlImgeMovie(indexPath: Int, size: ImageType) -> String? {
        switch size {
        case .small:
            return self.movieApiService.getBaseUrlImg() + "\(movies[indexPath].posterPath ?? "")"
        case .middle:
            return self.movieApiService.getBaseUrlImg() + "\(searchResultMovies[indexPath].backdropPath ?? "")"
        case .big:
            return self.movieApiService.getBaseUrlImg() + "\(movies[indexPath].backdropPath ?? "")"
        }
    }
}
