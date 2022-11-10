//
//  ErrorResponseEntity.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation

struct ErrorResponseEntity: Codable {
    var code: String?
    var message: String?
    var codeMessage: String?
    
    static var genericError: ErrorResponseEntity {
        return ErrorResponseEntity(code: "", message: StaticLabel.genericError)
    }
}
