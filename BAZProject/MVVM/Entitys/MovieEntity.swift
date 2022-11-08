//
//  MovieEntity.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation

struct MovieEntity {
    let id: Int
    let title: String
    let posterPath: String
}

enum LanguageType: String {
    case en = "English"
    case es = "Espanol"
}

enum MovieType: String {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    
    var endPoint: String {
        switch self {
            
        case .trending:
            return Endpoints.shared.trending
        case .nowPlaying:
            return Endpoints.shared.nowPlaying
        case .popular:
            return Endpoints.shared.popular
        case .topRated:
            return Endpoints.shared.topRated
        case .upcoming:
            return Endpoints.shared.upcoming
        }
    }
}
