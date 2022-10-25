//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - Object: Movie Information
struct InfoMovies : Codable {
    var adult: Bool?
    var backdrop_path: String?
    let id: Int?
    let title: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

// MARK: - Object: Array Movies
struct ArrayMovies: Codable {
    let results: [InfoMovies]
}
