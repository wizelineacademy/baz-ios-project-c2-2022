//
//  Category.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 13/11/22.
//

import Foundation
struct Category: Decodable {
    var name: String
    var endPoint: String
    var icon: String
    var description: String
    var movies : [Movie]?
}
