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
    let adult: Bool
    let gender, id: Int
    let name: String
    let originalName: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
