//
//  Detail.swift
//  BAZProject
//
//  Created by 1017143 on 24/10/22.
//

import Foundation

// MARK: - More Sections
public enum MovieSections: String {
    case similar
    case recommended
    var secctionName: String {
        switch self {
        case .similar:
            return "similar"
        case .recommended:
            return "recommendations"
        }
    }
}
