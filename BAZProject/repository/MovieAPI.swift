//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI: MovieAPIProtocol,MovieAPIConstantsProtocol {
    var interactor: MovieHomeDataExternalToInteractorProtocol?
    /// This function does not receive parameters, call the service of movies
    func setMovies<T : Codable>(urlCategoria: String, _ enumCategories: String) -> T? {
        guard let url = URL(string: urlCategoria)
        else {
            return nil
        }
        URLSession.shared.dataTask(with: url){
            data,response,error in
            guard let datos = data, error == nil, let result = response as? HTTPURLResponse
            else{
                return
            }
            if result.statusCode == 200{
                guard let getDeserialization: Result<T> = self.decode(data: datos) else { return }
                DispatchQueue.main.async {
                    self.interactor?.responseListMovies(dataMovie: getDeserialization, enumCategories)
                }
            }
        }.resume()
        return nil
    }
    /// This function is generic and receive parameters, serialize of json to object
    ///  - parameters
    ///     - data:  Is the json info
    ///     - jsonDecoder: The jsonDecoder instance
    func decode<T:Decodable>(data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) -> T?{
        return try? jsonDecoder.decode(T.self, from: data)
    }
}
