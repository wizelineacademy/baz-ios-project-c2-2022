//
//  ViewModelMovies.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation

struct movieByCategory {
    var nameCategory : String
    var movies : [Movie]
}

class HomeViewModel  {
    var refreshData = { () -> () in }
    
    var responseMoviesByCategory: [movieByCategory] = []

    var categories : [movieByCategory] = []{
        didSet {
            refreshData()
        }
    }
    
    /// Method to load the list of movie categories
    func loadCategoriesMovies(){
        CategoriesLocalDataManager.getCategories{ result in
            switch result {
            case let .success(categories):
                for category in categories {
                    self.moviesByCategory(category)
                }
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    private func moviesByCategory(_ category: Category){
        MoviesService.getMoviesByCategory(endPoint: category.endPoint){ result in
            switch result {
                case let .success(movies):
                let category = movieByCategory(nameCategory: category.name, movies: movies )
                self.categories.append(category)
                case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
}


