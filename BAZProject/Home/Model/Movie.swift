//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let backdropPath: String
    let cast: [CastResults]
}

struct MovieApiModel: Codable {
    var results: [MovieResults]
}

struct MovieResults: Codable {
    var id: Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_title: String?
    var media_type: String?
    var genre_ids: [Int]?
    var vote_average: Double?
    var popularity: Double?
    var poster_path: String?
    var title: String?
    var overview: String?
    var original_language: String?
    var vote_count: Int?
    var release_date: String?
    var video: Bool?
}

struct CastApiModel: Codable {
    var cast: [CastResults]
}

struct CastResults: Codable {
    var adult: Bool?
    var gender: Int?
    var id: Int?
    var name: String?
    var profile_path: String?
    var character: String?
    
}
