//
//  CreditAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 14/11/22.
//

import Foundation

struct CreditAPI: GenericRequestProtocol {
    
    ///getCredits
    /// - Parameter idMovie: id to search credit movies
    /// - Returns: Movies actors
    /// - throws: if any basic condition dont success, this return empty array
    func getCredits(with idMovie: String, completion: @escaping (Result<CreditResponse, Error>) -> Void) {
        let urlStr = urlBase + "/movie/\(idMovie)/credits?api_key=\(apiKey)&language=en-US"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        getFetch(with: URLRequest(url: url), completion: completion)
    }
}


