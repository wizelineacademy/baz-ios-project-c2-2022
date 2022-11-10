//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI: GenericRequestProtocol {
    ///Get Movies By Category
    /// - Parameter category: category by enum
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func getMovies(by category: CategoryFilterMovie, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let urlStr = category == .trending ? urlBase + "/trending/movie/day?api_key=\(apiKey)" : urlBase + "/movie/\(category.codeUrl)?api_key=\(apiKey)&language=es&region=MX&page=1"
        guard let url = URL(string: urlStr) else { completion(Result.failure(APIError.urlError)); return }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
}
