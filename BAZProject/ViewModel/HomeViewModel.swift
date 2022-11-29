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
    let clientAPI: Networkable
    var responseMoviesByCategory: [movieByCategory] = []
    var categoryList: [EndPoint] = [.trending, .popular, .topRate, .upcoming, .nowPlaying]

    var categories : [movieByCategory] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    init(clientApi: Networkable = ClientAPI()){
        self.clientAPI = clientApi
    }
    
    /// Method to load the list of movie categories
    func loadMoviesCategories(){
        for category in categoryList {
            self.getMovies(for: category)
        }
    }
    
    /// Method to get movies according to a category
    ///  - Parameter category: Movie category
    private func getMovies(for category: EndPoint){
        let similarMoviesService = category.getCase()
        clientAPI.load(request: similarMoviesService.request){ response in
            switch response {
            case .success(let movies):
                do {
                    let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: movies)
                    let movies = moviesResponse.results
                    let moviesByCategory = movieByCategory(nameCategory: category.getCase().name, movies: movies)
                    self.categories.append(moviesByCategory)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


