//
//  ApiURL.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 13/10/22.
//

import Foundation

enum ApiURL{
    case Trendig
    case NowPlaying
    case Popular
    case TopRated
    case UpComing
    
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
        }
    }
}
