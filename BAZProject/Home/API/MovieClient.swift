//
//  MovieClient.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 18/10/22.
//

import Foundation

class MovieClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<MovieApiModel?, APIError>) -> Void) {
        fetch(with: movieFeedType.request , decode: { json -> MovieApiModel? in
            guard let movieFeedResult = json as? MovieApiModel else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}
