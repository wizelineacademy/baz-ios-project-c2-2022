//
//  MoviesAPIProtocol.swift
//  BAZProject
//
//  Created by 1028092 on 23/11/22.
//

import Foundation
protocol MovieAPIProtocol{
    var interactor: MovieHomeDataExternalToInteractorProtocol? {get set}
    func setMovies<T : Codable>(urlCategoria: String, _ enumCategories: String) -> T?
}

protocol MovieAPIConstantsProtocol{
    var APIKEY: String { get }
    var TRENDINGURL: String { get }
    var NOWPLAYING: String { get }
    var NAMEOBJECTRESPONSE: String { get }
    var URLIMAGE: String { get }
}

protocol MovieHomeDataExternalToInteractorProtocol{
    var movieAPI: MovieAPIProtocol? {get set}
    func responseListMovies<T : Codable>(dataMovie: Result<T>, _ enumValue: String)
}

extension MovieAPIConstantsProtocol{
    var APIKEY: String { "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"}
    
    var URLGENERAL: String { "https://api.themoviedb.org/3" }
    
    var PAGEANDLANGUAGE: String {"&language=es&region=MX"}
    
    var SEARCHID: String { "&query=" }
    
    var TRENDINGURL: String { "\(URLGENERAL)/trending/movie/day\(APIKEY)\(PAGEANDLANGUAGE)"}
    
    var NOWPLAYING: String {
        "\(URLGENERAL)/movie/now_playing\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var POPULAR: String {
        "\(URLGENERAL)/movie/popular\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var TOPRATED: String {
        "\(URLGENERAL)/movie/top_rated\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var UPCOMING: String {
        "\(URLGENERAL)/movie/upcoming\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var REVIEWS: String {
        "\(URLGENERAL)/movie/{movieID}/reviews\(APIKEY)"
    }
    
    var SIMILAR: String {
        "\(URLGENERAL)/movie/{movieID}/similar\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var RECOMMENDATIONS: String {
        "\(URLGENERAL)/movie/{movieID}/recommendations\(APIKEY)\(PAGEANDLANGUAGE)"
    }
    
    var SEARCH: String {
        "\(URLGENERAL)/search/movie\(APIKEY)\(PAGEANDLANGUAGE)\(SEARCHID)"
    }
    
    var NAMEOBJECTRESPONSE: String { return "results"}
    
    var URLIMAGE: String { return "https://image.tmdb.org/t/p/w500"}
    
    
}
