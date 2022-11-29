//
//  CastMovie.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 28/11/22.
//

import Foundation
// MARK: - Cast
struct Cast: Codable {
    var adult: Bool?
    var gender, id: Int?
    var knownForDepartment: Department?
    var name, originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castID: Int?
    var character, creditID: String?
    var order: Int?
    var department: Department?
    var job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment
        case name
        case originalName
        case popularity
        case profilePath = "profile_path"
        case castID
        case character
        case creditID
        case order, department, job
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}


