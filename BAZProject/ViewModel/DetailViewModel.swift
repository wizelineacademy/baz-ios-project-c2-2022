//
//  DetailViewModel.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 14/11/22.
//

import Foundation

class DetailViewModel {
    var refreshData = { () -> () in }
    
    var similar : [Movie] = []

    var movie: Movie = Movie()
    
    /// Method to display similar movies
         /// - Parameter idMovie : Movie id to find similar
    func loadSimilarMovies(idMovie: Int){
        MoviesService.getMoviesByCategory(endPoint:"/movie/\(idMovie)/similar?api_key="){ result in
            switch result {
            case let .success(movies):
                self.similar = movies
            case .failure(_):
                debugPrint("error")
            }
        }
    }
}


