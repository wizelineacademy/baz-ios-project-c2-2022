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
    
    ///Get Movies By Category
    /// - Parameter category: category by enum
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func getMovies(by category: CategoryFilterMovie, completion: @escaping (Result<ResponseMovie, Error>) -> Void) {
        let urlStr = urlBase + "/movie/\(category.codeUrl)?api_key=\(apiKey)&language=es&region=MX&page=1"
        guard let url = URL(string: urlStr) else { completion(Result.failure(APIError.urlError)); return }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
    
    /// Decode info type data to a Movie model
    /// - Parameters:
    ///    - data: Info received in type Data.
    ///    - decoder:Custom JsonDecoder
    func decodeInfo<T:Decodable>(with data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let error as NSError{
            debugPrint("Error parsing: \(error.debugDescription)")
            return nil
        }
    }
    ///Search Movies By Name
    /// - Parameter title: title´s movie to search`
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func searchMovie(with title: String, completion: @escaping (Result<ResponseMovie, Error>) -> Void) {
        let urlStr = urlBase + "/search/movie?api_key=" + apiKey + "&language=en-US&&query=\(title)&page=1&include_adult=false"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        getFetch(with: URLRequest(url: url), completion: completion)
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
    
    /// URLSession request
    ///  - Parameter request: request to API
    ///  - Returns: Result custorm type and Error if this appear
    func getFetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let result: T = self.decodeInfo(with: data) else {
                completion(Result.failure(APIError.decodeError))
                return
            }
            completion(Result.success(result))
        }.resume()
    }
}
