//
//  StringExt.swift
//  BAZProject
//
//  Created by 1017143 on 20/10/22.
//
import Foundation

extension String {
    func trimmingAllSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return components(separatedBy: characterSet).joined()
    }
}
