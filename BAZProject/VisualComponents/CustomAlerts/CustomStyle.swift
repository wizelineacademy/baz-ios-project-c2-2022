//
//  CustomStyle.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import Foundation

enum CustomStyle {
    
    case error
    case alert
    case confirm
    
    var title: String {
        switch self {
        case .error:
            return staticLabel.titleError
        case .alert:
            return staticLabel.titleAlert
        case .confirm:
            return staticLabel.titleConfirm
        }
    }
    
}
