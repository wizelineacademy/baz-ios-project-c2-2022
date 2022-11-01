//
//  Movie.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation

struct Movie: Codable,Hashable,Identifiable {
    var id: Int64
    var title: String
    var poster_path: String
    var original_language: String
    var backdrop_path: String
    var overview: String
    var vote_average: Double
    var vote_count: Int
    var popularity: Double
}
struct Result: Codable{
    let results: [Movie]
}
