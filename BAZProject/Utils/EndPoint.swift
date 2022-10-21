//
//  EndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 17/10/22.
//

import Foundation
import UIKit

protocol EndPoint {
    var url: URL? { get }
}

struct QueryItems {
    var items: [URLQueryItem] = []

    init() {
        items.append(URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"))
        items.append(URLQueryItem(name: "language", value: "es"))
    }
}

struct EndPointComponents {
    var components: URLComponents = URLComponents()

    init(path: String) {
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = QueryItems.init().items
    }
}

struct TrendingEndPoint: EndPoint {
    var url: URL? { createUrl() }

    private func createUrl() -> URL? {
        return EndPointComponents.init(path: "/3/trending/movie/day").components.url
    }
}

struct NowPlayingEndPoint: EndPoint {
    var url: URL? { createURL() }

    private func createURL() -> URL? {
        return EndPointComponents.init(path: "/3/movie/now_playing").components.url
    }
}

struct PopularEndPoint: EndPoint {
    var url: URL? { createURL() }

    private func createURL() -> URL? {
        return EndPointComponents.init(path: "/3/movie/popular").components.url
    }
}

struct TopRatedEndPoint: EndPoint {
    var url: URL? { createURL() }

    private func createURL() -> URL? {
        return EndPointComponents.init(path: "/3/movie/top_rated").components.url
    }
}

struct UpcomingEndPoint: EndPoint {
    var url: URL? { createURL() }

    private func createURL() -> URL? {
        return EndPointComponents.init(path: "/3/movie/upcoming").components.url
    }
}

struct SearchEndPoint: EndPoint {
    var query: String
    var url: URL? { createURL(query: query) }

    private func createURL(query: String) -> URL? {
        var components = EndPointComponents.init(path: "/3/search/movie").components
        components.queryItems?.append(URLQueryItem(name: "query", value: query))
        return components.url
    }

    init(query: String) {
        self.query = query
    }
}

struct KeywordEndPoint: EndPoint {
    var query: String
    var url: URL? { createURL(query: query) }

    private func createURL(query: String) -> URL? {
        var components = EndPointComponents.init(path: "/3/search/keyword").components
        components.queryItems?.append(URLQueryItem(name: "query", value: query))
        return components.url
    }

    init(query: String) {
        self.query = query
    }
}

struct SimilarMovieEndPoint: EndPoint {
    var movieId: String
    var url: URL? { createURL(movieId: movieId) }

    private func createURL(movieId: String) -> URL? {
        return EndPointComponents.init(path: "/3/movie/\(movieId)/similar").components.url
    }

    init(movieId: String) {
        self.movieId = movieId
    }
}

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
