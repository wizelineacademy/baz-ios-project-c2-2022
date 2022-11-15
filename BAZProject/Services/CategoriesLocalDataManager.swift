//
//  CategoriesLocalDataManager.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 12/11/22.
//

import Foundation
import UIKit


struct CategoriesLocalDataManager {
    
/// Function to decode json file of Movie Categories
    ///  - Returns Category list
    static func getCategories(completion: @escaping (Result<[Category], Error>) -> Void ){
        guard let url = Bundle(identifier: "com.wizeline.BAZProject.movies")?.url(forResource: "categories", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let categories = try? JSONDecoder().decode([Category].self, from: data)
               else{
                   completion(.failure(CustomError.noData))
                   return
               }
        completion(.success(categories))
    }
}

