//
//  SearchAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 10/11/22.
//

import Foundation

final class SearchAPI: GenericRequestProtocol {
    
    ///Search Movies By Name
    /// - Parameter title: title´s movie to search`
    /// - Returns: Movies Array
    /// - throws: if any basic condition dont success, this return empty array
    func searchMovie(with title: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let urlStr = urlBase + "/search/movie?api_key=" + apiKey + "&language=en-US&&query=\(title)&page=1&include_adult=false"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
    
}
