//
//  DetailViewModel.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 14/11/22.
//

import Foundation

class DetailViewModel {
    var refreshData = { () -> () in }
    let clientAPI: Networkable

    var cast: [Cast] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    var moviesSimilar: [Movie] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    var moviesRecommended: [Movie] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    var movieReviews: [Review] = []{
        didSet {
            DispatchQueue.main.async {
                self.refreshData()
            }
        }
    }
    
    init(clientApi: Networkable = ClientAPI()){
        self.clientAPI = clientApi
    }

    /// Method to get the credits of a movie
         /// - Parameter movieID : Movie id to find cast
    func loadCast(for movieID: Int){
        let creditsMovieService = EndPoint.credits(movieID).getCase()
        clientAPI.load(request: creditsMovieService.request){ response in
            switch response {
            case .success(let response):
                do {
                    let credits = try JSONDecoder().decode(CreditsResponse.self, from: response)
                    self.cast = credits.cast
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Method to display similar movies
         /// - Parameter movieID : Movie id to find similar
    func loadSimilar(for movieID: Int){
        let similarMoviesService = EndPoint.similar(movieID).getCase()
        clientAPI.load(request: similarMoviesService.request){ response in
            switch response {
            case .success(let response):
                do {
                    let movies = try JSONDecoder().decode(MoviesResponse.self, from: response)
                    self.moviesSimilar = movies.results
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Method to display recommended movies
         /// - Parameter movieID : Movie id to find similar
    func loadRecommended(for movieID: Int){
        let similarMoviesService = EndPoint.recommendations(movieID).getCase()
        clientAPI.load(request: similarMoviesService.request){ response in
            switch response {
            case .success(let response):
                do {
                    let movies = try JSONDecoder().decode(MoviesResponse.self, from: response)
                    self.moviesRecommended = movies.results
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadReviews(for movieID: Int){
        let similarMoviesService = EndPoint.recommendations(movieID).getCase()
        clientAPI.load(request: similarMoviesService.request){ response in
            switch response {
            case .success(let response):
                do {
                    let reviewsResponse = try JSONDecoder().decode(ReviewsResponse.self, from: response)
                    self.movieReviews = reviewsResponse.reviews
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

