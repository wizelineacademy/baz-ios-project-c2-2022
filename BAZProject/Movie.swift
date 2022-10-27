//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct ResultsMovie: Decodable{
    let results: [Movie]
}

struct Movie : Decodable {
    let id: Int
    let title: String
    let poster_path: String
    let popularity: Double
    let release_date: String
    let vote_average: Double
}
