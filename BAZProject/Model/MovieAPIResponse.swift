//
//  MovieAPIResponse.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 28/10/22.
//

import Foundation

struct MovieAPIResponse: Codable {
    let page: Int?
    let results: [Movie]
    let totalPages, totalResults: Int?
}
