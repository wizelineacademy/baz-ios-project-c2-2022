//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable{
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalTitle: String
    let mediaType: String
    let genreIds: [Int]
    let voteAverage: Double
    let popularity: Double
    let title: String
    let posterPath: String
    let overview: String
    let originalLanguage: String
    let voteCount: Int
    let releaseDate: String
    let video: Bool?
}
