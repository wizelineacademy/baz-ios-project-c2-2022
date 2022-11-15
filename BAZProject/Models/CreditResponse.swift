//
//  CreditResponse.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 14/11/22.
//

import Foundation

struct CreditResponse: Codable {
    let actors: [Credit]
    
    enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
