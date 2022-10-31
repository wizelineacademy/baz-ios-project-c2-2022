//
//  API.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 30/10/22.
//

import Foundation

struct API: Decodable {
    let page: Int
    let results: [Movie]
}
