//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct ResultsMovie: Decodable {
    let page: Int
    let total_pages: Int
    let total_results: Int
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
