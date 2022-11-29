//
//  Movie.swift
//  BAZProject
//
//
import Foundation

// MARK: - Result
struct Movie: Codable {
    let title, overview, posterPath, backdrop: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case id
    }
}
