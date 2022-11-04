//
//  MoviesService.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation

 final class MoviesService{
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    private enum Endpoint {
        case listMovies
        case trending
        case nowPlaying
        case popular
        case topRated
        case upcoming
        case keyword
        case search
        case reviews
        case similar
        case recomendations
        
        
        var path: String {
            switch self {
            case .listMovies:
                return "/trending/movie/day?api_key=\(apiKey)"
            case .trending:
                return "/trending/movie/day?api_key=\(apiKey)"
            case .nowPlaying:
                return "/movie/now_playing?api_key=\(apiKey)"
            case .popular:
                return "/movie/popular?api_key=\(apiKey)"
            case .topRated:
                return "/movie/top_rated?api_key=\(apiKey)"
            case .upcoming:
                return "/movie/upcoming?api_key=\(apiKey)"
            case .keyword:
                return "/search/keyword?api_key=\(apiKey)"
            case .search:
                return "/search/movie?api_key=\(apiKey)"
            case .reviews:
                return "/movie/603/reviews?api_key=\(apiKey)&language=es"
            case .similar:
                return "/movie/603/similar?api_key=\(apiKey)a&language=es"
            case .recomendations:
                return "/movie/603/recommendations?api_key=\(apiKey)&language=es"
            }
        }
        
        var url: String {
            switch self {
            case .listMovies, .trending, .nowPlaying, .popular, .topRated, .upcoming :
                return "\(baseUrl)\(path)"
            case .keyword:
                return "\(baseUrl)\(path)"
            case .search:
                return "\(baseUrl)\(path)"
            case .reviews:
                return "\(baseUrl)\(path)"
            case .similar:
                return "\(baseUrl)\(path)"
            case .recomendations:
                return "\(baseUrl)\(path)"
            }
        }
    }
    
     static func getAllMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            guard Reachability.isConnectedToNetwork(), let url = URL(string: Endpoint.listMovies.url) else {
                completion(.failure(CustomError.noConnection))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print(#function, "🧨 Request: \(request)\nError: \(error)")
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(CustomError.noData))
                    return
                }

                do {
                    let movies = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(.success(movies.results))
                } catch let error {
                    print(#function, "🧨 Request: \(request)\nError: \(error)")
                    completion(.failure(error))
                }
            }.resume()
        }
}
