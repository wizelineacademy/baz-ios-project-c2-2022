//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - MovieDay
struct MovieDay: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let original_title: String?
}

