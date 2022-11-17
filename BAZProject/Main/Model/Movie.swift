//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - ResultsMovie
struct ResultsMovie: Codable {
    let results: [Movie]
}

// MARK: - MovieSearch
struct Movie: Codable {
    let adult: Bool
    let overview: String
    let originalTitle: String
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let title: String
    let posterPath: String
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case overview
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case title
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - SearchResultCellViewData
struct SearchResultCellViewData {
    let title: String
    let posterPath: String
}

// MARK: - MoreMovies
public enum MoreMovies: String {
    case similar
    case recommended = "recommendations"
    case cast
}

// MARK: - MovieSections
public enum MovieSections : Int {
    case trending   = 0
    case nowPlaying = 1
    case topRated   = 2
    case popular    = 3
    case upcoming   = 4
    
    var section : String {
        switch self {
        case .trending: return "/trending/movie/day"
        case .nowPlaying: return "/movie/now_playing"
        case .popular: return "/movie/popular"
        case .topRated: return "/movie/top_rated"
        case .upcoming: return "/movie/upcoming"
        }
    }
}
