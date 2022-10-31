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
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
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
            guard let moviesArray: [Movie] = decodeInfo(with: movies) else {
                return []
            }
            return moviesArray
        }
    }
    
    /// Decode info type data to a Movie model
    /// - Parameters:
    ///    - data: Info received in type Data.
    ///    - decoder:Custom JsonDecoder
    func decodeInfo<T:Decodable>(with data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
    
    /// Download image
    /// - Parameter name: name of image to download
    /// - Returns: Image of type UIIMage
    func getImage(with name: String) -> UIImage {
        let image = UIImage(named: "poster") ?? UIImage()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(name)"),
                let data = try? Data(contentsOf: url) else {
            return image
        }
        return UIImage(data: data) ?? image
    }

}
