//
//  ApiURL.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 13/10/22.
//

import Foundation
import UIKit

enum ApiURL{
    case Trendig
    case NowPlaying
    case Popular
    case TopRated
    case UpComing
    case Keyword
    case Search
    case Reviews
    case Similar
    case Recommendations
    
    var url: String {
        switch self {
        case .Trendig:
            return "/trending/movie/day"
        case .NowPlaying:
            return "/movie/now_playing"
        case .Popular:
            return "/movie/popular"
        case .TopRated:
            return "/movie/top_rated"
        case .UpComing:
            return "/movie/upcoming"
        case .Keyword:
            return "/search/keyword"
        case .Search:
            return "/search/movie"
        case .Reviews:
            return "/movie/{movieID}/reviews"
        case .Similar:
            return "/movie/{movieID}/similar"
        case .Recommendations:
            return "/movie/{movieID}/recommendations"
        }
    }
}
