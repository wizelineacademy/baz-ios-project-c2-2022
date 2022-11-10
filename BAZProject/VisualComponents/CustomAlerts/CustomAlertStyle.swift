//
//  CustomStyle.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

enum CustomAlertStyle {
    
    case error
    case alert
    case confirm
    
    var title: String {
        switch self {
        case .error:
            return StaticLabel.titleError
        case .alert:
            return StaticLabel.titleAlert
        case .confirm:
            return StaticLabel.titleConfirm
        }
    }
    
    var image: UIImage {
        switch self {
        case .error:
            return UIImage(systemName: "person.fill.xmark") ?? UIImage()
        case .alert:
            return UIImage(systemName: "exclamationmark.triangle.fill") ?? UIImage()
        case .confirm:
            return UIImage(systemName: "person.crop.circle.badge.questionmark") ?? UIImage()
        }
    }
}
