//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

final class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    var movies: [Movie] = []
    
    func getMovies() -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        do {
            let dataInfo = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
            return saveMoviesData(dataMovies: dataInfo!)
        }
    }
    
    func saveMoviesData(dataMovies: Data) -> [Movie] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
        do {
            let decoded = try decoder.decode([Movie].self, from: dataMovies)
            return decoded
        } catch {
            print("Failed to decode JSON")
            return []
        }
    }
    
    func getImageMovie(nameImage: String) -> UIImage {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(nameImage)"),
                let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        return UIImage(data: data) ?? UIImage()
    }

}
