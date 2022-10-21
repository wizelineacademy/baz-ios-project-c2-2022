//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - MovieDay
struct MovieDay: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let original_title: String?
}

// MARK: - CategoryMovieType
public enum CategoryMovieType:String, CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var endpoint: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
    
    var typeName: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
