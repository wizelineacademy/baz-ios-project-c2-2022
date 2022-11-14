//
//  TrendingEndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 07/11/22.
//

import Foundation

struct TrendingEndPoint: PaginatedEndPoint {
    var page: Int = 1
    var url: URL? { createUrl(page: page) }

    private func createUrl(page: Int?) -> URL? {
        var components = EndPointComponents.init(path: "/3/trending/movie/day").components
        components.queryItems?.append(URLQueryItem(name: "page", value: String(page ?? 1)))
        return components.url
    }
}
