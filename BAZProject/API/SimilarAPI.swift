//
//  SimilarAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 12/11/22.
//

import Foundation

final class SimilarAPI: GenericRequestProtocol {
    ///searchSimilarMovies
    /// - Parameter idMovie: id to search similar movies
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func searchSimilarMovies(with idMovie: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let urlStr = urlBase + "/movie/\(idMovie)/similar?api_key=\(apiKey)&language=es"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
    
}
