//
//  CustomError.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation

enum CustomError {
    case noConnection, noData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return "Ocurrio un error en el servicio..."
        case .noConnection: return "Sin conexión a internet..."
        }
    }
}
