//
//  ReviewData.swift
//  BAZProject
//
//  Created by 1028092 on 23/11/22.
//

import Foundation

struct Review : Codable {
    let author, content, createdAt, id, updatedAt, url: String?
    let authorDetails: AuthorDetails?
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct AuthorDetails : Codable {
    let name, username, avatarPath: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
