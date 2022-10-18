//
//  Result.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 18/10/22.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
