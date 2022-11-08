//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var originalTitle: String
    var mediaType: String?
    var genreIds: [Int]
    var voteAverage: Double
    var popularity: Double
    var title: String
    var posterPath: String?
    var overview: String
    var originalLanguage: String
    var voteCount: Int
    var releaseDate: String?
    var video: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case popularity = "popularity"
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case video = "video"
    }
}
