//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private var endPointUrl: String = ""
    
    var movies: [Movie] = []
    
    func getMovies(endPoint: MovieEndpoint) -> [Movie] {
        
        setUrl(endPoint: endPoint)
        
        guard let url = URL(string: endPointUrl + apiKey),
              let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        if let api = try? JSONDecoder().decode(API.self, from: data) {
            movies = api.results
            return movies
        } else {
            return []
        }
    }
    
    func setUrl(endPoint: MovieEndpoint) {
        switch endPoint {
        case .trending:
            endPointUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .nowPlaying:
            endPointUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key="
        case .popular:
            endPointUrl = "https://api.themoviedb.org/3/movie/popular?api_key="
        case .topRated:
            endPointUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case .Upcoming:
            endPointUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key="
        }
    }
    
}
