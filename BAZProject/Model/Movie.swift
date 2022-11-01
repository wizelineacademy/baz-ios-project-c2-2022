//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
        let adult: Bool?
        let backdropPath: String?
        let id: Int?
        let title, originalLanguage, originalTitle, overview: String?
        let posterPath: String?
        let genreIDS: [Int]?
        let popularity: Double?
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?
}
