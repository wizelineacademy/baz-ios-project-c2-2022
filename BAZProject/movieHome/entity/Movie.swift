//
//  Movie.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation

struct Movie: Codable {
    var id: Int64
    var title: String
    var poster: String
    var language: String
    var backdrop: String
    var overview: String
    var voteAverage: Double
    var voteCount: Int
    var popularity: Double
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case poster = "poster_path"
        case language = "original_language"
        case backdrop = "backdrop_path"
        case overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
    }
}
struct Result: Decodable{
    let results: [Movie]
}
