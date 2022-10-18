//
//  MovieFeed.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 18/10/22.
//

import Foundation

enum MovieFeed {
    case Trendig
    case NowPlaying
    case Popular
    case TopRated
    case UpComing
    case Keyword(query: String)
    case Search(query: String)
    case Reviews(movieID: String)
    case Similar(movieID: String)
    case Recommendations(movieID: String)
}
extension MovieFeed: Endpoint {
    
    var apiKey: String {
        switch self {
        case .Trendig, .NowPlaying, .Popular, .TopRated, .UpComing, .Reviews, .Similar, .Recommendations:
            return "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case .Keyword(let query), .Search(let query):
            return "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&query=\(query)"
        }
    }
    
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .Trendig:
            return "/3/trending/movie/day"
        case .NowPlaying:
            return "/3/movie/now_playing"
        case .Popular:
            return "/3/movie/popular"
        case .TopRated:
            return "/3/movie/top_rated"
        case .UpComing:
            return "/3/movie/upcoming"
        case .Keyword:
            return "/3/search/keyword"
        case .Search:
            return "/3/search/movie"
        case .Reviews(let movieID):
            return "/3/movie/\(movieID)/reviews"
        case .Similar(let movieID):
            return "/3/movie/\(movieID)/similar"
        case .Recommendations(let movieID):
            return "/3/movie/\(movieID)/recommendations"
        }
    }
}
