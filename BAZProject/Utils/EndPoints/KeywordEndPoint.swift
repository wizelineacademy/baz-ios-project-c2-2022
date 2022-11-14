//
//  KeywordEndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 07/11/22.
//

import Foundation

struct KeywordEndPoint: EndPoint {
    var query: String
    var url: URL? { createURL(query: query) }

    private func createURL(query: String) -> URL? {
        var components = EndPointComponents.init(path: "/3/search/keyword").components
        components.queryItems?.append(URLQueryItem(name: "query", value: query))
        return components.url
    }

    init(query: String) {
        self.query = query
    }
}
