//
//  Endpoint.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 18/10/22.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var apiKey: String { get }
}
extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
