//
//  MovieResponse.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 08/11/22.
//

import Foundation

struct MovieResponse: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
