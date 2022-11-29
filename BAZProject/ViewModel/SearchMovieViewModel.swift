//
//  SearchMovieViewModel.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 15/11/22.
//

import Foundation

class SearchMovieViewModel {
    var refreshData = { () -> () in }
    let clientAPI: Networkable
    
    var movies : [Movie] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    init(clientApi: Networkable = ClientAPI()){
        self.clientAPI = clientApi
    }
    
    /// Method to search for movies
         /// - Parameter query : Search criteria string
    func searchMovie(with query: String){
        let similarMoviesService = EndPoint.search(query).getCase()
        clientAPI.load(request: similarMoviesService.request){ response in
            switch response {
            case .success(let response):
                do {
                    let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: response)
                    self.movies = moviesResponse.results
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
