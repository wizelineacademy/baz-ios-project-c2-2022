//
//  PopularEndPoint.swift
//  BAZProject
//
//  Created by 1030364 on 07/11/22.
//

import Foundation

struct PopularEndPoint: EndPoint {
    var url: URL? { createURL() }

    private func createURL() -> URL? {
        return EndPointComponents.init(path: "/3/movie/popular").components.url
    }
}
