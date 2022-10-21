//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

final class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let urlBase: String = "https://api.themoviedb.org/3"
    
    /// Function get movies of API
    /// - Return: Movies Array
    func getMovies() -> [Movie] {
        guard let url = URL(string: urlBase + "/trending/movie/day?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        do {
            let dataInfo = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
            guard let movies = dataInfo else {
                return []
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(formatter)
            return decodeInfo(with: movies, decoder: decoder)
        }
    }
    
    /// Function decode data info into model Movie
    /// - Parameters:
    ///    - data: Info to decode in Data formater.
    ///    - decoder:
    func decodeInfo(with data: Data, decoder: JSONDecoder) -> [Movie] {
        do {
            let decoded = try decoder.decode([Movie].self, from: data)
            return decoded
        } catch {
            print("Failed to decode JSON")
            return []
        }
    }
    
    /// Function return a image
    /// - Parameter name: specific image name
    /// - Return: Image
    func getImage(with name: String) -> UIImage {
        let image = UIImage(named: "poster") ?? UIImage()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(name)"),
                let data = try? Data(contentsOf: url) else {
            return image
        }
        return UIImage(data: data) ?? image
    }

}
