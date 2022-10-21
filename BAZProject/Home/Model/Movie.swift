//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let poster_path: String
    let original_title: String
    let vote_average: Double
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
