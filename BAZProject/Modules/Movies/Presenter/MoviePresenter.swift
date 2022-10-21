//
//  MoviePresenter.swift
//  BAZProject
//
//  Created by 1017143 on 17/10/22.
//

import Foundation

class MoviePresenter {
    
    weak private var movieViewDelegate : MovieViewDelegate?
    private let movieApiService : MovieAPI
    private var movies : [Movie] =  []
    
    init(movieApiService: MovieAPI){
        self.movieApiService = movieApiService
    }
    
    /// Get the value of the delegate
    func setMovieDelegate(movieViewDelegate:MovieViewDelegate?){
        self.movieViewDelegate = movieViewDelegate
    }
    
    /// Makes a query to the service, places the value in an array and calls a function of the view
    func getMoviesByCategory(category: CategoryMovieType) {
        movieApiService.getMovies(category: category) { movies in
            if let movies = movies {
                self.movies = movies
                self.movieViewDelegate?.showMovies()
            }
        }
    }
    
    /// Get the number of movies included in the query
    ///
    /// - Returns: The number of movies
    func getTotalMovies() -> Int{
        return self.movies.count
    }
    
    /// Get a movie object from an array of movies
    ///
    /// - Parameter indexPath: Is the index of the array to query
    /// - Returns: The a Movie object
    func getMovie(indexPath: Int) -> Movie{
        return self.movies[indexPath]
    }
    
    /// Get the url of the image
    ///
    /// - Parameter indexPath: Is the index of the array the url of the image
    /// - Returns: A string type url
    func getUrlImgeMovie(indexPath: Int) -> String{
        return self.movieApiService.getBaseUrlImg() + "\(movies[indexPath].poster_path ?? "")"
    }
    
}

