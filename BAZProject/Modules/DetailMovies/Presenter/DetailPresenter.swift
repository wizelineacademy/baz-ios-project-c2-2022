//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by 1017143 on 24/10/22.
//

import Foundation

class DetailPresenter {
    weak private var movieDetailDelegate: MovieDetailDelegate?
    private let movieApiService: MovieAPI
    private var similarMovies: [Movie] =  []
    private var recomendedMovies: [Movie] =  []
    init(movieApiService: MovieAPI) {
        self.movieApiService = movieApiService
    }
    /// Get the value of the delegate
    func setDetailDelegate(movieDetailDelegate: MovieDetailDelegate?) {
        self.movieDetailDelegate = movieDetailDelegate
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    func getRecommendedMovie(idMovie: Int) {
        movieApiService.getMoviesSection(section: .recommended, idMovie: idMovie) { moviesSection in
            if let movies = moviesSection {
                self.recomendedMovies = movies
                self.movieDetailDelegate?.showMovieBySection(section: .recommended, movies: movies)
            }
        }
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    func getSimilarMovie(idMovie: Int) {
        movieApiService.getMoviesSection(section: .similar, idMovie: idMovie) { moviesSection in
            if let movies = moviesSection {
                self.similarMovies = movies
                self.movieDetailDelegate?.showMovieBySection(section: .similar, movies: movies)
            }
        }
    }
    /// Get the url of the image
    ///
    /// - Parameter indexPath: Is the index of the array the url of the image
    /// - Returns: A string type url
    func getUrlImgeMovie(indexPath: Int, section: MovieSections, size: ImageType) -> String? {
        if section == .similar {
            switch size {
            case .small:
                return self.movieApiService.getBaseUrlImg() + "\(similarMovies[indexPath].posterPath ?? "")"
            case .middle:
                return self.movieApiService.getBaseUrlImg() + "\(similarMovies[indexPath].posterPath ?? "")"
            case .big:
                return self.movieApiService.getBaseUrlImg() + "\(similarMovies[indexPath].backdropPath ?? "")"
            }
        } else {
            switch size {
            case .small:
                return self.movieApiService.getBaseUrlImg() + "\(recomendedMovies[indexPath].posterPath ?? "")"
            case .middle:
                return self.movieApiService.getBaseUrlImg() + "\(recomendedMovies[indexPath].posterPath ?? "")"
            case .big:
                return self.movieApiService.getBaseUrlImg() + "\(recomendedMovies[indexPath].backdropPath ?? "")"
            }
        }
    }
    /// Get a movie object from an array of movies
    ///
    /// - Parameter indexPath: Is the index of the array to query
    /// - Returns: The a Movie object
    func getMovie(indexPath: Int, section: MovieSections) -> Movie? {
        switch section {
        case .similar:
            return similarMovies[indexPath]
        case .recommended:
            return recomendedMovies[indexPath]
        }
    }
}
