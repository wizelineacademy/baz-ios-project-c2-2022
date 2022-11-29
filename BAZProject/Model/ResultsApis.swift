//
//  ResultsApis.swift
//  BAZProject
//
//  Created by 1028092 on 23/11/22.
//

import Foundation

// MARK: - Model Result
struct Result<T: Codable> : Codable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
