//
//  ViewModelMovies.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation

class ViewModelMovies  {
    
    var refreshData = { () -> () in }
    
    var movies : [Movie] = []{
        didSet {
            refreshData()
        }
    }
    
    func retriveMoviesList(){
        MoviesService.getAllMovies{ result in
            switch result{
            case let .success(movies):
                self.movies = movies
            case let .failure(error):
                self.movies = []
            }
        }
    }
    
    func searchMovies(query: String){
        MoviesService.searchMovies(query: query){ result in
                                   switch result{
                                   case let .success(movies):
                                       self.movies = movies
                                   case let .failure(error):
                                       self.movies = []
                                   }
        }
    }
    
    
}
