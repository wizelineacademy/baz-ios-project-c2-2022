//
//  Categories.swift
//  BAZProject
//
//  Created by 1028092 on 14/11/22.
//

import Foundation
enum Categories: String, CaseIterable {
    case trending = "Tendencias"
    case nowplaying = "Viendo Ahora"
    case popular = "Popular"
    case toprated = "Los más bucados"
    case upcoming = "Proximamente"
}

enum Recommendations: String, CaseIterable {
    case recommendation = "Recomendados"
    case similar = "Similar"
    case review = "Reseñas"
}

