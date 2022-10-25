//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation


enum Path: String {
    case pathStrMovies = "/trending/movie/day?api_key="
}

final class MovieAPI {
    
    private let apiKey: String = Bundle.main.infoDictionary?["MovieApiKey"] as? String ?? ""
    private let baseEndpoint: String = "https://api.themoviedb.org/3"
    
    /// API request creation to get movies
    
    func getMovies(completion: @escaping (Result<[InfoMovies], Error>) -> ()){
        if let urlString = URL(string: "\(baseEndpoint)\(Path.pathStrMovies.rawValue)\(apiKey)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let jsonData = self.parsingJson(jsonData: data!) {
                    completion(.success(jsonData.results))
                }
            }
            task.resume()
        }
    }
    
    /// Parsing json to get movie data.
   
    private func parsingJson(jsonData: Data) -> ArrayMovies? {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedData = try jsonDecoder.decode(ArrayMovies.self, from: jsonData)
            return decodedData
        }catch {
            print("Error al decodificar los datos")
            return nil
        }
        
    }
    
}
