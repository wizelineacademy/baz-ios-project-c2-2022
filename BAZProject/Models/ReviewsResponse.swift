//
//  ReviewsResponse.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 29/11/22.
//

import Foundation

// MARK: - ReviewsResponse
struct ReviewsResponse: Codable {
    var id: Int
    var reviews: [Review]
}

// MARK: - Review
struct Review: Codable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content, createdAt, id, updatedAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails
        case content
        case createdAt
        case id
        case updatedAt
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    var name, username, avatarPath: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath
        case rating
    }
}
