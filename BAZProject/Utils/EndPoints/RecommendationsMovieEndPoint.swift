//
//  File.swift
//  BAZProject
//
//  Created by 1030364 on 07/11/22.
//

import Foundation

struct RecommendationsMovieEndPoint: EndPoint {
    var movieId: String
    var url: URL? { createURL(movieId: movieId) }

    private func createURL(movieId: String) -> URL? {
        return EndPointComponents.init(path: "/3/movie/\(movieId)/recommendations").components.url
    }

    init(movieId: String) {
        self.movieId = movieId
    }
}
