//
//  Localizable+String.swift
//  BAZProject
//
//  Created by 1017143 on 07/11/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
