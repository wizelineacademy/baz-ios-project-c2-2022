//
//  MoviesResponse.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 28/10/22.
//

import Foundation

struct MoviesResponse: Codable {
    var page: Int?
    var results: [Movie]
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages
        case totalResults
    }
}
