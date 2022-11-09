//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct ResultsMovie: Decodable {
    let results: [Movie]
}

struct Dates: Decodable {
    let maximum: String
    let minimum: String
}

struct Movie: Decodable {
    let adult: Bool
    let overview: String
    let original_title: String
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let title: String
    let poster_path: String
    let popularity: Double
    let release_date: String
    let vote_average: Double
    let vote_count : Int
}


// MARK: - MovieSearch
struct MovieSearch: Codable {
    let results: [FoundMovies]
}

// MARK: - FoundMovies
struct FoundMovies: Codable {
    let name: String?
    let id: Int?
}
