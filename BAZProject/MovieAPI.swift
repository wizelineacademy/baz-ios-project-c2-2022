//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies() -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }

        var movies: [Movie] = []

        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String,
               let popularity = result.object(forKey: "popularity") as? Double,
               let release_date = result.object(forKey: "release_date") as? String,
               let vote_average = result.object(forKey: "vote_average") as? Double {
                movies.append(Movie(id: id, title: title, poster_path: poster_path, popularity: popularity, release_date: release_date, vote_average: vote_average ))
            }
        }

        return movies
    }

}
