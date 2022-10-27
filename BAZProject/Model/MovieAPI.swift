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
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String,
               let popularity = result.object(forKey: "popularity") as? Double,
               let release_date = result.object(forKey: "release_date") as? String,
               let vote_average = result.object(forKey: "vote_average") as? Double {
                movies.append(Movie(id: id, title: title, poster_path: poster_path, popularity: popularity, release_date: release_date, vote_average: vote_average))
            }
        }
        
        return movies
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
