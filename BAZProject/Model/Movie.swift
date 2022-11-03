//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - Object: Movie Information
struct InfoMovies: Codable{
    var adult: Bool?
    var backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIds: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    /// Associated values ​​CodingKeys is set simply by adopting it.
    enum CodingKeys: String, CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}

// MARK: - Object: Array Movies
struct ArrayMovies: Codable{
    let results: [InfoMovies]
}

public enum MoreMovies: String {
    case similar
    case recommended = "recommendations"
}
