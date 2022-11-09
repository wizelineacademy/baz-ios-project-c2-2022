//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

protocol MovieApiProtocol {
    func getAllMovies(movies: [MoviesWithCategory])
    func getSearchMovies(movies: [Movie])
}

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private var endPointUrl: String = ""
    var movieApiDelegate: MovieApiProtocol?
    
    var movies: [Movie] = []
    var allMovies: [MoviesWithCategory] = []
    
    func getMovies(){
        for endPoint in MovieEndpoint.allCases {
            setUrl(endPoint: endPoint)
            guard let url = URL(string: endPointUrl + apiKey),
                  let data = try? Data(contentsOf: url)
            else { return }
            if let api = try? JSONDecoder().decode(API.self, from: data) {
                movies = api.results
            }
            let movieSection = MoviesWithCategory(genre: endPoint.rawValue, movies: movies)
            allMovies.append(movieSection)
        }
        movieApiDelegate?.getAllMovies(movies: allMovies)
    }
    
    func getSearchMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=" + apiKey),
              let data = try? Data(contentsOf: url)
        else { return }
        var searchMovies: [Movie] = []
        if let api = try? JSONDecoder().decode(API.self, from: data) {
            searchMovies = api.results
        }
        movieApiDelegate?.getSearchMovies(movies: searchMovies)
    }
    
    func setUrl(endPoint: MovieEndpoint) {
        switch endPoint {
        case .Trending:
            endPointUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .NowPlaying:
            endPointUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key="
        case .Popular:
            endPointUrl = "https://api.themoviedb.org/3/movie/popular?api_key="
        case .TopRated:
            endPointUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case .Upcoming:
            endPointUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key="
        }
    }
    
}
