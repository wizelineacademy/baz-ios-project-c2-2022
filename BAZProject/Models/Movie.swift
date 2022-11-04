//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var title, originalLanguage, originalTitle, overview: String?
    var posterPath: String?
    var mediaType: MediaType?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case id, title
        case originalLanguage
        case originalTitle
        case overview
        case posterPath = "poster_path"
        case mediaType
        case genreIDS
        case popularity
        case releaseDate
        case video
        case voteAverage
        case voteCount
    }
}
enum MediaType: String, Codable {
    case movie = "movie"
}
