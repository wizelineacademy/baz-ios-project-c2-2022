//
//  PopularEndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 07/11/22.
//

import Foundation

struct PopularEndPoint: PaginatedEndPoint {
    var page: Int = 1
    var url: URL? { createURL(page: page) }

    private func createURL(page: Int?) -> URL? {
        var components = EndPointComponents.init(path: "/3/movie/popular").components
        components.queryItems?.append(URLQueryItem(name: "page", value: String(page ?? 1)))
        return components.url
    }
}
