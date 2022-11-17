//
//  EndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 17/10/22.
//

import Foundation
import UIKit

protocol EndPoint {
    var url: URL? { get }
}

protocol PaginatedEndPoint: EndPoint {
    var page: Int { get set }
}

struct QueryItems {
    var items: [URLQueryItem] = []

    init() {
        items.append(URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"))
        items.append(URLQueryItem(name: "language", value: "es"))
    }
}

struct EndPointComponents {
    var components: URLComponents = URLComponents()

    init(path: String) {
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = QueryItems.init().items
    }
}
