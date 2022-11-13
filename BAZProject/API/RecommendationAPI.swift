//
//  RecommendationAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 12/11/22.
//

import Foundation

final class RecommendationAPI: GenericRequestProtocol {
    
    ///searchRecommendationMovies
    /// - Parameter idMovie: id to search recommendation movies
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func searchRecommendationMovies(with idMovie: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let urlStr = urlBase + "/movie/\(idMovie)/recommendations?api_key=\(apiKey)&language=es"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
}
 //movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es
