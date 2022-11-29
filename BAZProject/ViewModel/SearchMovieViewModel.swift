//
//  SearchMovieViewModel.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 15/11/22.
//

import Foundation

class SearchMovieViewModel {
    var refreshData = { () -> () in }
    
    var movies : [Movie] = []{
        didSet {
            refreshData()
        }
    }
    
    /// Method to search for movies
         /// - Parameter query : Search criteria string
    func searchMovie(query: String){
        MoviesService.searchMovies(query: query){ result in
            switch result {
                case let .success(movies):
                self.movies = movies
                case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
