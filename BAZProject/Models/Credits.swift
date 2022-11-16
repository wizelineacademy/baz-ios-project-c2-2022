//
//  Credits.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 14/11/22.
//

import Foundation

struct Credit: Codable {
    var name: String
    var imagePath: String?
    var nameCharacter: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imagePath = "profile_path"
        case nameCharacter = "character"
    }
}
