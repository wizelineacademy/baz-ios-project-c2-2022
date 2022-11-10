//
//  Endpoints.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation

class Endpoints {
    let moviApi = "https://api.themoviedb.org/3/"
    let imgApi = "https://image.tmdb.org/t/p/w500/"
    let trending = "trending/movie/day?api_key="
    let search = "search/multi?api_key="
    let nowPlaying = "movie/now_playing?api_key="
    let popular = "movie/popular?api_key="
    let topRated = "movie/top_rated?api_key="
    let upcoming = "movie/upcoming?api_key="
    let similar = "similar?api_key="
    
    private init(){}
    
    static var shared: Endpoints = {
        let instance = Endpoints()
        return instance
    }()
    
    func getSearchUrl(language: String, query: String)-> String {
        return "\(self.moviApi)\(search)\(Constants.apiKey)&language=\(language)&query=\(clearQuery(query: query))&page=1"
    }
    
    func getTrendingMovie()-> String {
        return "\(self.moviApi)\(self.trending)\(Constants.apiKey)"
    }
    
    func getCategory(language: String, category: String)-> String {
        return "\(self.moviApi)\(category)\(Constants.apiKey)&language=\(language)&page=1"
    }
    
    func getSimilar(language: String, id: Int)-> String {
        return "\(self.moviApi)movie/\(id)/\(similar)\(Constants.apiKey)&language=\(language)&page=1"
    }
    
    func getDetail(language: String, id: Int) -> String {
        return "\(self.moviApi)movie/\(id)?api_key=\(Constants.apiKey)&language=\(language)&page=1"
    }
    
    private func clearQuery(query: String) -> String {
        return query.replacingOccurrences(of: " ", with: "%20")
    }
}
