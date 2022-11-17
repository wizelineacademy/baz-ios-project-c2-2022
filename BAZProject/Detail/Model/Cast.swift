//
//  Cast.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 14/11/22.
//

import Foundation

// MARK: - MoviesCast
struct MovieCast: Codable {
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let name: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
